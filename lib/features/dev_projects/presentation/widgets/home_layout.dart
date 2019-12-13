import 'package:dev_ideas/core/widgets/error_widget.dart';
import 'package:dev_ideas/features/dev_projects/domain/enteties/idea.dart';
import 'package:dev_ideas/features/dev_projects/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_ideas/injection_container.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sl<DevProjectsBloc>().dispatch(AddIdeaEvent(
              idea: Idea.withRandomID(
                  title: "Test",
                  projectName: "Test",
                  description: "Test",
                  photoURLs: [],
                  category: "Category",
                  status: DevStatus.IDEA)));
        },
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

  Widget _buildContent(DevProjectsState state, BuildContext context){
    if (state is EmptyDevProjectsBlocState){
      sl<DevProjectsBloc>().dispatch(LoadDevProjectsEvent());
      return _buildLoading();
    } else if (state is DevProjectsLoadingState){
      return _buildLoading();
    } else if (state is LoadedDevProjectsState){
      return _buildIdeasList(state.ideas, context);
    } else if (state is ErrorDevProjectsState){
      return Center(child: DevIdeasErrorWidget());
    } else if (state is LoadedDevProjectsWithFilterState){
      return Text("LOADED WITH FILTERS");
    } else {
      return Center(child: DevIdeasErrorWidget());
    }
  }

  Widget _buildIdeasList(List<Idea> ideas, BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final idea = ideas.elementAt(index);
        return ListTile(
          leading: _buildListTileIconForIdea(idea, context),
          title: Text(idea.title),
          subtitle: Text(idea.description),
        );
      },
      itemCount: ideas.length,
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
}
