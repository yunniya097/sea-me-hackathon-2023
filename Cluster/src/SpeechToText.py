import speech_recognition as sr
import pyaudio
import logging

def SpeechToText():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        logging.warning("Say Something")
        audio = r.record(source, duration=5)

    try:
        logging.warning("Recording...")
#        result = r.recognize_google(audio, "en-US")
        result = r.recognize(audio)
#        logging.warning(result)

        audios = result.split()
        logging.warning(audios)

        with open("/home/sea/sea-me-hackathon-2023/Cluster/src/commands.txt", "w") as file:
            file.write(result)
            logging.warning("text transmitted")

        return result

    except sr.UnknownValueError:
        logging.warning("could not understand")
        return ""

    except sr.RequestError as e:
        logging.warning("Request Error; {0}".format(e))
        return ""

text = SpeechToText()


