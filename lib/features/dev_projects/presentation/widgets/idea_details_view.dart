import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';

class IdeaDetailsPage extends StatelessWidget {
  final Idea idea;
  final bool editMode;

  IdeaDetailsPage(this.idea, {this.editMode = true});

  factory IdeaDetailsPage.newIdea() {
    Idea idea = Idea.withRandomID(
        title: "New Idea",
        description: "",
        category: "",
        status: DevStatus.IDEA);

    return IdeaDetailsPage(idea, editMode: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(idea.title),
      ),
      body: IdeaDetailsLayout(
        idea,
        editMode: editMode,
      ),
    );
  }
}

class IdeaDetailsLayout extends StatefulWidget {
  final Idea idea;
  final bool editMode;

  IdeaDetailsLayout(this.idea, {this.editMode = true});

  @override
  _IdeaDetailsLayoutState createState() => _IdeaDetailsLayoutState();
}

class _IdeaDetailsLayoutState extends State<IdeaDetailsLayout> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String title, description;
  DevStatus devStatus;

  @override
  void initState() {
    super.initState();

    this.title = widget.idea.title;
    this.description = widget.idea.description;
    this.devStatus = widget.idea.status;

    titleController.text = title;
    descriptionController.text = description;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildContent(context),
          _buildActionButton(context),
          _buildDeleteButton(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16.0),
        _buildTitleInput(context),
        SizedBox(height: 8.0),
        _buildDevStatusSelection(context),
        SizedBox(height: 8.0),
        _buildDescriptionInput(context),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildTitleInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: titleController,
        decoration:
            InputDecoration(hintText: "Title", border: OutlineInputBorder()),
        onChanged: (title) {
          if (title.isNotEmpty) {
            this.title = title;
          } else {
            this.title = "Unknown";
          }
        },
      ),
    );
  }

  Widget _buildDevStatusSelection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIdeaChip(),
        SizedBox(width: 8.0),
        _buildInDevChip(),
        SizedBox(width: 8.0),
        _buildDoneChip(),
      ],
    );
  }

  Widget _buildIdeaChip() {
    return ChoiceChip(
      avatar: CircleAvatar(
        child: Icon(Icons.lightbulb_outline),
      ),
      label: Text("IDEA"),
      selected: devStatus == DevStatus.IDEA,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            devStatus = DevStatus.IDEA;
          });
        }
      },
    );
  }

  Widget _buildInDevChip() {
    return ChoiceChip(
      avatar: CircleAvatar(
        child: Icon(Icons.code),
      ),
      label: Text("IN DEV"),
      selected: devStatus == DevStatus.DEVELOPMENT,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            devStatus = DevStatus.DEVELOPMENT;
          });
        }
      },
    );
  }

  Widget _buildDoneChip() {
    return ChoiceChip(
      avatar: CircleAvatar(
        child: Icon(Icons.done),
      ),
      label: Text("DONE"),
      selected: devStatus == DevStatus.FINISHED,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            devStatus = DevStatus.FINISHED;
          });
        }
      },
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: descriptionController,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Description",
        ),
        onChanged: (text) {
          description = text;
        },
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () => _actionButtonPress(context),
          child: Text(
            actionButtonText,
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  String get actionButtonText => widget.editMode ? "UPDATE" : "CREATE";

  Widget _buildDeleteButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlineButton(
          onPressed: () => _showDeletionConfirmationDialog(context),
          child: Text(
            "DELETE",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  void _showDeletionConfirmationDialog(BuildContext context) {
    showDialog(context: context, builder: _buildDeletionConfirmationDialog);
  }

  Widget _buildDeletionConfirmationDialog(BuildContext context) {
    return AlertDialog(
        title: Text("Delete DevIdea"),
        content: Text("Do you really want to delete this DevIdea permanently"),
        actions: <Widget>[
          MaterialButton(
            child: Text("CANCEL"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            child: Text("DELETE"),
            onPressed: () {
              Navigator.of(context).pop();
              _deleteIdea(context);
            },
          )
        ]);
  }

  void _actionButtonPress(BuildContext context) {
    _update();
    if (widget.editMode) {
      _updateIdea(context);
    } else {
      _createIdea(context);
    }
  }

  void _update() {
    widget.idea.title = this.title;
    widget.idea.description = this.description;
    widget.idea.status = this.devStatus;
  }

  void _updateIdea(BuildContext context) {
    sl<DevProjectsBloc>()
        .dispatch(UpdateIdeaEvent(ideaID: widget.idea.id, idea: widget.idea));
    Navigator.of(context).pop();
  }

  void _createIdea(BuildContext context) {
    sl<DevProjectsBloc>().dispatch(AddIdeaEvent(idea: widget.idea));
    Navigator.of(context).pop();
  }

  void _deleteIdea(BuildContext context) {
    sl<DevProjectsBloc>().dispatch(RemoveIdeaEvent(ideaID: widget.idea.id));
    Navigator.of(context).pop();
  }
}
