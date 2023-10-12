import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friday_virtual_assistant/api/api_service.dart';

import 'package:image_downloader/image_downloader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController userInputTextEditingController =
      TextEditingController();
  final SpeechToText speechToTextInstance = SpeechToText();
  String recordedAudioString = "";
  bool isLoading = false;
  bool speakFRIDAY = true;
  String modeOpenAI = "chat";
  String imageUrlFromOpenAI = "";
  String answerTextFromOpenAI = "";
  final TextToSpeech textToSpeechInstance = TextToSpeech();

  void initializeSpeechToText() async {
    await speechToTextInstance.initialize();

    setState(() {});
  }

  void startListeningNow() async {
    FocusScope.of(context).unfocus();

    await speechToTextInstance.listen(onResult: onSpeechToTextResult);

    setState(() {});
  }

  void stopListeningNow() async {
    await speechToTextInstance.stop();

    setState(() {});
  }

  void onSpeechToTextResult(SpeechRecognitionResult recognitionResult) {
    recordedAudioString = recognitionResult.recognizedWords;

    speechToTextInstance.isListening
        ? null
        : sendRequestToOpenAI(recordedAudioString);

    print("Speech Result:");
    print(recordedAudioString);
  }

  Future<void> sendRequestToOpenAI(String userInput) async {
    stopListeningNow();

    setState(() {
      isLoading = true;
    });

    //send the request to openAI using our APIService
    await APIService().requestOpenAI(userInput, modeOpenAI, 7).then((value) {
      setState(() {
        isLoading = false;
      });

      if (value.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Api Key you are/were using expired or it is not working anymore.",
            ),
          ),
        );
      }

      userInputTextEditingController.clear();

      final responseAvailable = jsonDecode(value.body);

      if (modeOpenAI == "chat") {
        setState(() {
          if (responseAvailable != null &&
              responseAvailable["choices"] != null &&
              responseAvailable["choices"].isNotEmpty) {
            answerTextFromOpenAI =
                responseAvailable["choices"][0]["text"].toString();

            print("ChatGPT Chatbot: ");
            print(answerTextFromOpenAI);
          } else {
            // Handle the case where responseAvailable or choices is null or empty
            print("ResponseAvailable or choices is null or empty.");
          }
        });

        if (speakFRIDAY == true) {
          textToSpeechInstance.speak(answerTextFromOpenAI);
        }
      } else {
        //image generation
        // setState(() {
        //   imageUrlFromOpenAI = responseAvailable["data"][0]["url"];

        //   print("Generated Dale E Image Url: ");
        //   print(imageUrlFromOpenAI);
        // });
        setState(() {
          if (responseAvailable != null &&
              responseAvailable["data"] != null &&
              responseAvailable["data"]["url"] != null) {
            imageUrlFromOpenAI = responseAvailable["data"]["url"];

            print("Generated DALL·E Image Url: ");
            print(imageUrlFromOpenAI);
          } else {
            // Handle the case where responseAvailable or data or url is null
            print("ResponseAvailable, data, or url is null.");
          }
        });
      }
    }).catchError((errorMessage) {
      setState(() {
        isLoading = false;
      });
      print(errorMessage.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: " + errorMessage.toString(),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    initializeSpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (!isLoading) {
            setState(() {
              speakFRIDAY = !speakFRIDAY;
            });
          }

          textToSpeechInstance.stop();
        },
        child: speakFRIDAY
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("images/sound.png"),
              )
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("images/mute.png"),
              ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.purpleAccent.shade100,
            Colors.deepPurple,
          ])),
        ),
        title: Image.asset(
          "images/logo.png",
          width: 140,
        ),
        titleSpacing: 10,
        elevation: 2,
        actions: [
          //chat
          Padding(
            padding: const EdgeInsets.only(right: 4, top: 4),
            child: InkWell(
              onTap: () {
                setState(() {
                  modeOpenAI = "chat";
                });
              },
              child: Icon(
                Icons.chat,
                size: 40,
                color: modeOpenAI == "chat" ? Colors.white : Colors.grey,
              ),
            ),
          ),

          //image
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 4),
            child: InkWell(
              onTap: () {
                setState(() {
                  modeOpenAI = "image";
                });
              },
              child: Icon(
                Icons.image,
                size: 40,
                color: modeOpenAI == "image" ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),

              //image
              Center(
                child: InkWell(
                  onTap: () {
                    speechToTextInstance.isListening
                        ? stopListeningNow()
                        : startListeningNow();
                  },
                  child: speechToTextInstance.isListening
                      ? Center(
                          child: LoadingAnimationWidget.beat(
                            size: 300,
                            color: speechToTextInstance.isListening
                                ? Colors.deepPurple
                                : isLoading
                                    ? Colors.deepPurple[400]!
                                    : Colors.deepPurple[200]!,
                          ),
                        )
                      : Image.asset(
                          "images/assistant_icon.png",
                          height: 300,
                          width: 300,
                        ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //text field with a button
              Row(
                children: [
                  //text field
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: TextField(
                        controller: userInputTextEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "how can i help you?",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  //button
                  InkWell(
                    onTap: () {
                      if (userInputTextEditingController.text.isNotEmpty) {
                        sendRequestToOpenAI(
                            userInputTextEditingController.text.toString());
                      }
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.deepPurpleAccent),
                      duration: const Duration(
                        milliseconds: 1000,
                      ),
                      curve: Curves.bounceInOut,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              //display result
              modeOpenAI == "chat"
                  ? SelectableText(
                      answerTextFromOpenAI,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : modeOpenAI == "image" && imageUrlFromOpenAI.isNotEmpty
                      ? Column(
                          //image
                          children: [
                            Image.network(
                              imageUrlFromOpenAI,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String? imageStatus = await ImageDownloader.downloadImage(imageUrlFromOpenAI);

                                if(imageStatus != null)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Image downloaded Successfully."),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              child: const Text(
                                "Download this Image",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container()
            ],
          ),
        ),
      ),
    );
  }
}
