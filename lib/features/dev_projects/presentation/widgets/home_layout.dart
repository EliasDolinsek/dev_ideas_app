import 'package:dev_ideas/core/widgets/error_widget.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_ideas/injection_container.dart';

import 'idea_details_view.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onCreateClicked(context),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: sl<DevProjectsBloc>().state,
          builder: (content, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return _buildContent(data, context);
            } else if (snapshot.hasError) {
              return DevIdeasErrorWidget();
            } else {
              return _buildLoading();
            }
          }),
    );
  }

  Widget _buildContent(DevProjectsState state, BuildContext context) {
    if (state is EmptyDevProjectsBlocState) {
      sl<DevProjectsBloc>().dispatch(LoadDevProjectsEvent());
      return _buildLoading();
    } else if (state is DevProjectsLoadingState) {
      return _buildLoading();
    } else if (state is LoadedDevProjectsState) {
      return _buildLoaded(state.ideas, context);
    } else if (state is ErrorDevProjectsState) {
      return Center(child: DevIdeasErrorWidget());
    } else if (state is LoadedDevProjectsWithFilterState) {
      return _buildLoaded(state.ideas, context);
    } else {
      return Center(child: DevIdeasErrorWidget());
    }
  }

  Widget _buildLoaded(List<Idea> ideas, BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSearchBar(),
        _buildIdeasDisplay(ideas, context)
      ],
    );
  }

  Widget _buildIdeasDisplay(List<Idea> ideas, BuildContext context){
    if(ideas.isNotEmpty){
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final idea = ideas.elementAt(index);
          return _buildIdeaTile(idea, context);
        },
        itemCount: ideas.length,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text("No ideas found"),
      );
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(),
        ),
        onChanged: (search) {
          if (search.isNotEmpty) {
            final event = LoadDevProjectsWithFilterEvent(
                title: search,
                projectName: search,
                category: search,
                devStatus: null);
            sl<DevProjectsBloc>().dispatch(event);
          } else {
            sl<DevProjectsBloc>().dispatch(LoadDevProjectsEvent());
          }
        },
      ),
    );
  }

  Widget _buildIdeaTile(Idea idea, BuildContext context) {
    return ListTile(
      leading: _buildListTileIconForIdea(idea, context),
      title: Text(
        idea.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: idea.description.isEmpty
          ? null
          : Text(
              idea.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      onTap: () => _onIdeaTileTapped(context, idea),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // ignore: missing_return
  Widget _buildListTileIconForIdea(Idea idea, BuildContext context) {
    switch (idea.status) {
      case DevStatus.IDEA:
        return Icon(
          Icons.lightbulb_outline,
          color: Theme.of(context).primaryColor,
        );
      case DevStatus.DEVELOPMENT:
        return Icon(
          Icons.code,
          color: Theme.of(context).primaryColor,
        );
      case DevStatus.FINISHED:
        return Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        );
    }
  }

  void _onCreateClicked(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => IdeaDetailsPage.newIdea()));
  }

  void _onIdeaTileTapped(BuildContext context, Idea idea) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => IdeaDetailsPage(idea)));
  }
}
