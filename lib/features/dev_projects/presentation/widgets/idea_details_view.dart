import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';

class IdeaDetailsView extends StatefulWidget {
  final Idea idea;
  final bool editMode;

  IdeaDetailsView(this.idea, {this.editMode = true});

  factory IdeaDetailsView.newIdea() {
    Idea idea = Idea.withRandomID(
        title: "New Idea",
        description: "",
        category: "",
        status: DevStatus.IDEA);
    return IdeaDetailsView(idea, editMode: false);
  }

  @override
  _IdeaDetailsViewState createState() => _IdeaDetailsViewState();
}

class _IdeaDetailsViewState extends State<IdeaDetailsView> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteIdea(context))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildContent(context)),
          _buildActionButton(context)
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


  Widget _buildIdeaChip(){
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

  Widget _buildInDevChip(){
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

  Widget _buildDoneChip(){
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
        onChanged: (text){
          description = text;
        },
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
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

  void _actionButtonPress(BuildContext context) {
    _update();
    if (widget.editMode) {
      _updateIdea(context);
    } else {
      _createIdea(context);
    }
  }

  void _update(){
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
