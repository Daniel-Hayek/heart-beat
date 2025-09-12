import pandas as pd 
import numpy as np
import mlflow
from mlflow.models.signature import infer_signature

from sklearn.model_selection import train_test_split, cross_validate
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.metrics import classification_report, confusion_matrix, f1_score


mlflow.set_tracking_uri("http://localhost:5000")
mlflow.set_experiment("Stress Level Analysis")
mlflow.sklearn.autolog(log_models=False)

artifact_path = 'stress_level_artifact'

with mlflow.start_run(run_name="CVM_ovo_cv10fold") as run:

    df = pd.read_csv("../datasets/synthetic_sleep_stress_dataset_final.csv")

    X = df[["Sleep Duration", "Physical Activity Level", "Heart Rate", "Daily Steps"]]

    y = df["Stress Level"]

    print(X)
    print(y)

    scaler = StandardScaler()
    X = scaler.fit_transform(X)

    X_train, X_validation, y_train, y_validation = train_test_split(X, y, random_state = 42, test_size = 0.2)

    y_train = y_train.to_numpy()

    y_validation = y_validation.to_numpy()

    #================================ Classifiers ================================

    svm_ovo_model = SVC(kernel='rbf', decision_function_shape='ovo', random_state=42, C=1.0, gamma='scale')

    #================================ K-Cross Validation ================================

    cv_results = cross_validate(
            svm_ovo_model, 
            X_train, 
            y_train,
            cv = 10,
            return_estimator = True,
            scoring = "accuracy"
        )

    scores = cv_results["test_score"]
    print("CV Scores")
    print(scores)

    best_idx = np.argmax(scores)
    best_score = scores[best_idx]
    best_model = cv_results["estimator"][best_idx]
    print("Best Model Score", best_score)


    #================================ Results ================================
    
    y_validation_pred = best_model.predict(X_validation)
    print("Confusion Matrix:")
    print(confusion_matrix(y_validation, y_validation_pred))

    class_report = classification_report(y_validation, y_validation_pred)
    print("Classification Report:")
    print(class_report)

    #================================ MLFlow Logging ================================

    try:

        input_example = df[["Sleep Duration", "Physical Activity Level", "Heart Rate", "Daily Steps"]].head()

        signature = infer_signature(X_train, best_model.predict(X_train))

        mlflow.log_metric("f1_weighted", f1_score(y_validation, y_validation_pred, average="weighted"))
        mlflow.log_metric("accuracy", best_score,)  # best CV score
        mlflow.log_metric("f1_macro", f1_score(y_validation, y_validation_pred, average="macro"))

        mlflow.sklearn.log_model(
            sk_model=best_model,
            name="svm_ovo_best_model",
            registered_model_name="svm_ovo_best_model",
            input_example=input_example,
            signature=signature
        )

        mlflow.log_params({
        "kernel": "rbf",
        "decision_function_shape": "ovo",
        "C": 1.0,
        "gamma": "scale",
        "random_state": 42
        })
    except Exception as e:
        print("Failed to log:", e)