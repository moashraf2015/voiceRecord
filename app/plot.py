# import matplotlib.pyplot as plt
import numpy as np
# import wave
# import sys


# spf = wave.open("raw_data/dev/1.wav", "r")

# # Extract Raw Audio from Wav File
# signal = spf.readframes(-1)
# signal = np.fromstring(signal, "Int16")


# # If Stereo
# if spf.getnchannels() == 2:
#     print("Just mono files")
#     sys.exit(0)

# plt.figure(1)
# plt.title("Signal Wave...")
# plt.plot(signal)
# plt.show()


from scipy.io.wavfile import read
import matplotlib.pyplot as plt

# "../Arabic Dataset 300/backward/00000001_NO_01.wav", "../Arabic Dataset 500/account/S01.01.19.wav"]
# files = ["audio/v_0.wav", "audio/v_1.wav",
#          "audio/v_2.wav", "audio/Recording0001.wav", "audio/Recording0002.wav", "audio/Recording0003.wav",
#          "audio/Recording0004.wav", "audio/Recording0005.wav"]

files = [
    "NewHeadPhones/0.wav",
    "NewHeadPhones/1.wav",
    "NewHeadPhones/2.wav"
]

for i, file in enumerate(files):

    plt.subplot(len(files), 1, i+1)
    input_data = read(file)
    audio = input_data[1]
    plt.plot(audio)
    plt.ylim([-1.1, 1.1])
    plt.ylabel(file.split('/')[-1])
    # plt.xlabel("Time")

plt.show()
x = 000
