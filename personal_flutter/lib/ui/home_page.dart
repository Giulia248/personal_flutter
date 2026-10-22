// As you can see we have MultiBlocProvider coming from our bloc library.
// Because we want to load data from server and want to load it only once, so in our build method we inject the UserRepository.
// With MultiBlocProvider form bloc you can add multiple Blocs in your class to use them all over it.
// Also where you can to place this repository you need to have a class. In our case it is Scaffold.

// So what MultiBlocProvider is doing is that, it moving the data from server and it is making the data and states available all over the child.

// Inside the blocBody you can see the BlocProvider.
// If you are familiar with Getx it is like Get.put. Inside the BlocProvider we inject our bloc i.e UserBloc with the repository.
// As we have already inject our bloc in the top we can access the event inside the blocBody.

// First after injecting the bloc with the repository we then add the event i.e LoadUserEvent with the cascading operator which triggers the UserLoadingState
// from the UserBloc.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_flutter/blocs/user/user_blocs.dart';
import 'package:personal_flutter/blocs/user/user_events.dart';
import 'package:personal_flutter/blocs/user/user_states.dart';
import 'package:personal_flutter/network/models/user_model.dart';
import 'package:personal_flutter/network/repo/repositories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Api fetch BLOC')),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(UserRepository())..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is UserLoadedState) {
            List<UserModel> userList = state.users;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        '${userList[index].firstName}  ${userList[index].lastName}',
                        style: const TextStyle(color: Colors.white),
                      ),

                      subtitle: Text(
                        '${userList[index].email}',
                        style: const TextStyle(color: Colors.white),
                      ),

                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userList[index].avatar.toString(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
