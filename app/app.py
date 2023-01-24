import numpy as np
from pydub import AudioSegment
import sys
import librosa
from keras.models import load_model
import pyaudio
from queue import Queue



model = load_model(".\saved_model\WWD2.h5")




chunk_duration = 1 # Each read length in seconds from mic.
fs = 22050 # sampling rate for mic
chunk_samples = int(fs * chunk_duration) # Each read length in number of samples.

# Each model input data duration in seconds, need to be an integer numbers of chunk_duration
feed_duration = 10
feed_samples = int(fs * feed_duration)

assert feed_duration/chunk_duration == int(feed_duration/chunk_duration)

def get_audio_input_stream(callback):
    stream = pyaudio.PyAudio().open(
        format=pyaudio.paFloat32,
        channels=1,
        rate=fs,
        input=True,
        frames_per_buffer=chunk_samples,
        input_device_index=0,
        stream_callback=callback)
    return stream




# Queue to communiate between the audio callback and main thread
q = Queue()

run = True

silence_threshold = 100
data = np.zeros(feed_samples, dtype='float32')

def callback(in_data, frame_count, time_info, status):
    global run, timeout, data, silence_threshold           
    data0 = np.frombuffer(in_data, dtype='float32')
    # if np.abs(data0).mean() < silence_threshold:
    #     sys.stdout.write('-')
    #     return (in_data, pyaudio.paContinue)
    q.put(data0)
    return (in_data, pyaudio.paContinue)

stream = get_audio_input_stream(callback)
stream.start_stream()


try:
    while run:
        data = q.get()
        mfcc = librosa.feature.mfcc(y=data, sr=fs, n_mfcc=40)
        mfcc_processed = np.mean(mfcc.T, axis=0)
        prediction = model.predict(np.expand_dims(mfcc_processed, axis=0))
        if prediction[:, 1] > 0.96:
            sys.stdout.write('1')

except (KeyboardInterrupt, SystemExit):
    stream.stop_stream()
    stream.close()
    run = False
        
stream.stop_stream()
stream.close()
