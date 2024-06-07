import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from keras.src.layers import GRU, SimpleRNN, LSTM, Dense
from tensorflow.keras.layers import Dense, SimpleRNN, Embedding, LSTM, GRU, Dropout
from keras.api.callbacks import EarlyStopping
from tensorflow.keras.models import Sequential
from sklearn.metrics import confusion_matrix, f1_score, precision_score, recall_score, accuracy_score


param_grid = {
    'embedding_dim': [50, 100, 200],
    'rnn_units': [32, 64, 128],
    'rnn_type': ['SimpleRNN'],
    'dropout': [0.2, 0.4],
    'optimizer': ['rmsprop', 'sgd'],
    'batch_size': [32, 64],
    'activation': ['relu', 'tanh'],
}


def execute_grid_search(param_grid, x_train, y_train, x_test, y_test, num_words):
    best_accuracy = 0
    best_model_accuracy = None
    least_accuracy = 1
    least_model_accuracy = None
    table = []
    # get the combination of all parameters and add to a table
    for n in param_grid['embedding_dim']:
        for m in param_grid['rnn_units']:
            for o in param_grid['rnn_type']:
                for p in param_grid['optimizer']:
                    for q in param_grid['activation']:
                        for r in param_grid['dropout']:
                            model = build_model(n, m, o, p, num_words, q, r)
                            model.summary()
                            history = model.fit(
                                x_train, y_train, epochs=5, batch_size=32, validation_split=0.2, verbose=0, callbacks=[EarlyStopping(patience=3)])
                            # can I make a subplot of all the models in 2 figures
                            # plot_model_history(history)

                            # evaluation = model.evaluate(x_test, y_test)
                            loss, accuracy, precision, recall = model.evaluate(
                                x_test, y_test)
                            if accuracy > best_accuracy:
                                best_accuracy = accuracy
                                best_model_accuracy = [
                                    n, m, o, p, accuracy, loss, precision, recall
                                ]
                            if accuracy < least_accuracy:
                                least_accuracy = accuracy
                                least_model_accuracy = [
                                    n, m, o, p, accuracy, loss, precision, recall
                                ]

                            print(f'Loss: {loss}, Accuracy: {accuracy}, Precision: {precision}, Recall: {recall}')

                            table.append({
                                "title": [f"${n}_${m}_${o}_${p}"],
                                "embedding_dim": [n],
                                "rnn_units": [m],
                                "rnn_type": [o],
                                "optimizer": [p],
                                "activation": [q],
                                "dropout": [r],
                                "accuracy": [accuracy],
                                "loss": [loss],
                                "precision": [precision],
                                "recall": [recall],
                            })

    # write the table to a file
    pd.DataFrame(table).to_csv("model_results.csv")

    # result = pd.DataFrame(table)

    # select all the model where the accuracy is greater than 0.9
    # best_accuracy = result[result['accuracy'] > 0.9]

    return {
        "table": pd.DataFrame(table),
        "best_accuracy": best_accuracy,
        "best_model_accuracy": best_model_accuracy,
        "least_accuracy": least_accuracy,
        "least_model_accuracy": least_model_accuracy
    }


# Plot training & validation accuracy values and loss values
def plot_model_history(history):
    # values to plot
    #  loss: loss value for training data
    #  accuracy: accuracy value for training data
    #  val_loss: loss value for validation data
    #  val_accuracy: accuracy value for validation data
    print(history.history.keys())

    # Plot training & validation accuracy values
    plt.figure(figsize=(12, 4))

    plt.subplot(1, 2, 1)
    plt.plot(history.history['accuracy'])
    plt.plot(history.history['val_accuracy'])
    plt.title('Model accuracy')
    plt.ylabel('Accuracy')
    plt.xlabel('Epoch')
    plt.legend(['Train', 'Validation'], loc='upper left')

    # Plot training & validation loss values
    plt.subplot(1, 2, 2)
    plt.plot(history.history['loss'])
    plt.plot(history.history['val_loss'])
    plt.title('Model loss')
    plt.ylabel('Loss')
    plt.xlabel('Epoch')
    plt.legend(['Train', 'Validation'], loc='upper left')

    plt.show()


# embedding\_dim & rnn\_units & rnn\_type & optimizer & activation & accuracy & loss & precision & recall \\
# 100 & 64 & SimpleRNN & rmsprop & relu &  0.987444 & 0.061306 & 0.992701 & 0.912752 \\
# 50 & 64 & LSTM & rmsprop & relu & 0.982960 & 0.080875 & 0.949367 & 0.931677 \ \
# 50 & 32 & LSTM & rmsprop & relu &  0.989238 & 0.052878 & 0.987179 & 0.939024 \\

def build_model(embedding_dim=128, rnn_units=128, rnn_type='LSTM', optimizer='adam', num_words=5000, activation='sigmoid', dropout=0.5):
    model_build = Sequential()
    model_build.add(Embedding(input_dim=num_words,
                    output_dim=embedding_dim, input_length=10))
    if rnn_type == 'LSTM':
        model_build.add(LSTM(rnn_units, return_sequences=False))
    elif rnn_type == 'GRU':
        model_build.add(GRU(rnn_units, return_sequences=False))
    else:
        model_build.add(SimpleRNN(rnn_units, return_sequences=False))
    model_build.add(Dense(128, activation=activation))
    if rnn_type == 'LSTM':
        model_build.add(Dropout(dropout))
    model_build.add(Dense(64, activation=activation))
    model_build.add(Dense(1, activation="sigmoid"))
    model_build.compile(optimizer=optimizer, loss='binary_crossentropy', metrics=[
                        'accuracy', 'precision', 'recall'])
    return model_build


def plot_confusion_matrix(cm):
    plt.figure(figsize=(8, 6))  # Adjust the figure size as needed
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues')
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.title('Confusion Matrix')
    plt.show()


def test_rnn_model(model, x_test, y_test):
    pred = model.predict(x_test) > 0.5
    cm = confusion_matrix(y_test, pred)
    plot_confusion_matrix(cm)
    # print the f1 score, precision, recall, and accuracy
    f1 = f1_score(y_test, pred)
    precision = precision_score(y_test, pred)
    recall = recall_score(y_test, pred)
    accuracy = accuracy_score(y_test, pred)
    print(f'GRU Model: F1 Score: {f1}, Precision: {precision}, Recall: {recall}, Accuracy: {accuracy}')