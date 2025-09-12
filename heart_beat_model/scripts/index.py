import pandas as pd 
import numpy as np
import mlflow

from sklearn.model_selection import train_test_split, cross_validate
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.metrics import classification_report, confusion_matrix, f1_score

mlflow.set_tracking_uri("http://localhost:5000")
mlflow.set_experiment("Stress Level Analysis")
mlflow.sklearn.autolog(log_models=False)

with mlflow.start_run(run_name="CVM_ovo_cv10fold") as run:

    df = pd.read_csv("../datasets/synthetic_sleep_stress_dataset_final.csv")

    X = df[["Sleep Duration", "Physical Activity Level", "Heart Rate", "Daily Steps"]]

    y = df["Stress Level"]

    print(X)
    print(y)

    scaler = StandardScaler()
    X = scaler.fit_transform(X)

    X_train, X_validation, y_train, y_validation = train_test_split(X, y, random_state = 42, test_size = 0.2)


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

    y_validation_pred = best_model.predict(X_validation)
    print("Confusion Matrix:")
    print(confusion_matrix(y_validation, y_validation_pred))

    class_report = classification_report(y_validation, y_validation_pred)
    print("Classification Report:")
    print(class_report)

    mlflow.log_metric("f1_weighted", f1_score(y_validation, y_validation_pred, average="weighted"))

    mlflow.log_param("dummy_param", 123)

    mlflow.sklearn.log_model(best_model, "svm_ovo_best_model")