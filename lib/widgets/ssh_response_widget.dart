import 'package:flutter/material.dart';
import 'package:ssh_exec/blocs/ssh_bloc.dart';
import 'package:ssh_exec/models/ssh_response_message.dart';
import 'package:ssh_exec/resources/bloc_provider.dart';


class SshResponseWidget extends StatelessWidget {

  //SshResponseWidget(this._sshResponseStream);
  SshBloc _sshBloc;
  final TextEditingController _updateController = TextEditingController();

  void disposeUpdateController() {
    _updateController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _sshBloc = BlocProvider.of<SshBloc>(context);
    return StreamBuilder<SshResponseMessage>(
        stream: _sshBloc.sshResultStream,
        initialData: SshResponseMessage.empty(),
        builder: (context, snapshot) {
          _updateController.text = snapshot.data.responseString;
          return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: snapshot.data.isfinalMessage
                      ? TextField(
                          controller: _updateController,
                          enabled: false,
                          maxLines: null,
                          scrollPadding: EdgeInsets.all(10),
                          decoration: null,
                        )
                      : ListTile(
                          title: TextField(
                            controller: _updateController,
                            enabled: false,
                            scrollPadding: EdgeInsets.all(10),
                            decoration: null,
                          ),
                          trailing: CircularProgressIndicator(),
                        )));
        });
  }
}
