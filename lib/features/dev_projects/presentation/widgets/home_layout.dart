import 'package:dev_ideas/features/dev_projects/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_ideas/injection_container.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DevProjectsBloc>(
      builder: (_) => sl<DevProjectsBloc>(),
      child: Column(
        children: <Widget>[
          BlocBuilder<DevProjectsBloc, DevProjectsState>(
            builder: (context, state){
              if(state is EmptyDevProjectsBlocState){
                BlocProvider.of<DevProjectsBloc>(context).dispatch(LoadDevProjectsEvent());
                return _buildLoading();
              } else if (state is LoadedDevProjectsState){

              } else if (state is LoadedDevProjectsWithFilterState){

              } else if (state is ErrorDevProjectsState) {

              } else {

              }
              return Text(state.toString());
            },
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
