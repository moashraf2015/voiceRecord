###### IMPORTS ###################
import threading
import time
import sounddevice as sd
import librosa
import numpy as np
from tensorflow.keras.models import load_model
from queue import Queue
import sys



##### CONSTANTS ################
fs = 22050
seconds = 2

model = load_model(".\saved_model\WWD2.h5")
q = Queue()

##### LISTENING THREAD #########
def listener():
    while True:
        myrecording = sd.rec(int(seconds * fs), samplerate=fs, channels=1)
        sd.wait()
        mfcc = librosa.feature.mfcc(y=myrecording.ravel(), sr=fs, n_mfcc=40)
        mfcc_processed = np.mean(mfcc.T, axis=0)
        q.put(mfcc_processed)



def voice_thread():
    listen_thread = threading.Thread(target=listener, name="ListeningFunction")
    listen_thread.start()

##### PREDICTION THREAD #############
def prediction():
    while True:
        y = q.get()
        prediction = model.predict(np.expand_dims(y, axis=0))
        if prediction[:, 1] > 0.96:
            sys.stdout.write('1')
        else:
            sys.stdout.write('-')
        

    time.sleep(0.1)


voice_thread()
prediction()
