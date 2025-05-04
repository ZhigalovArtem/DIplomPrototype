import 'package:flutter/material.dart';
import 'package:web_chat/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? formCheck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.40,
        height: MediaQuery.sizeOf(context).height * 0.50,
        child: Form(
          key: authKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'email'),
                onSaved: (newValue) => email = newValue,
                onChanged: (value) => email = value,
                validator: (value) {
                  if (formCheck != true) {
                    return 'Неверные данные';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'password'),
                onSaved: (newValue) => password = newValue,
                onChanged: (value) => password = value,
                validator: (value) {
                  if (value != null) {
                    return 'Пустой пароль';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          var form = authKey.currentState;
                          form?.validate();
                          // await formValidate(email,
                          // password); //добавить функцию валидации формы
                          if (form!.validate()) {
                            form.save();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const IndexPage(),
                                )); //создать начальную страницу приложения
                          }
                        },
                        child: const Text('LogIn')),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Registration'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
