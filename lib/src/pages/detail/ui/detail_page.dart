import 'package:bitcoin_app/src/core/api_source/enums/notifier_state.dart';
import 'package:bitcoin_app/src/pages/detail/view_model/detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String date = (arguments['date']);
    String logoUrl = (arguments['logoUrl']);

    return ViewModelBuilder<DetailViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  appBar: AppBar(title: Text('Detail')),
                  body: model.state == NotifierState.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : model.failure != null
                          ? Center(child: Text(model.failure.toString()))
                          : _InfoPrice(
                              model: model,
                              date: date,
                              urlLogo: logoUrl,
                            )),
            ),
        viewModelBuilder: () => DetailViewModel(),
        onModelReady: (viewModel) => viewModel.getInfo(date));
  }
}

class _InfoPrice extends StatelessWidget {
  final String date;
  final String urlLogo;
  final DetailViewModel model;

  const _InfoPrice(
      {Key? key,
      required this.model,
      required this.date,
      required this.urlLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 10,
      color: Colors.blue,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(date.split(' ').first.toString(),
                  style: TextStyle(fontSize: 35.0, color: Colors.white)),
              SizedBox(height: 30.0),
              SvgPicture.network(
                urlLogo,
                width: 80,
                height: 80,
              ),
              SizedBox(height: 30.0),
              Text(
                '${model.priceUsd!.split('.').first} USD',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Text(
                '${model.priceEur!.split('.').first} EUR',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ],
          )),
    );
  }
}
