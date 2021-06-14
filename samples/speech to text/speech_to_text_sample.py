import speech_recognition as sr

# obtain audio from the microphone
recognizer = sr.Recognizer()
mic = sr.Microphone()


with mic as source:
    print('Adjusting for ambient noise...')
    recognizer.adjust_for_ambient_noise(source)
    print('Say something!')
    audio = recognizer.listen(source)
    print('Finished listening')

    try:
        print('Recognizing text...')
        transcription = recognizer.recognize_google(audio)
        print('Transcription:', transcription)
    except Exception:
        pass