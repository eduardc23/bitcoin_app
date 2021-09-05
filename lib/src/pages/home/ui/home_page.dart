import 'package:bitcoin_app/src/core/api_source/enums/notifier_state.dart';
import 'package:bitcoin_app/src/pages/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            body: model.state == NotifierState.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : model.failure != null
                    ? Center(child: Text(model.failure.toString()))
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            _TodayPrice(model: model),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              reverse: true,
                              itemCount:
                                  model.lastPrices!.first.prices.length,
                              itemBuilder: (context, index) {
                                var date = model
                                    .lastPrices!.first.timestamps[index]
                                    .toString();
                                var price =
                                    model.lastPrices!.first.prices[index];
                                return GestureDetector(
                                  onTap: () => model.navToDetail(context,
                                      date, model.bitcoinModel!.logoUrl),
                                  child: _LastWeeksPrice(
                                      logoUrl:
                                          model.bitcoinModel!.logoUrl,
                                      date: date,
                                      price: price),
                                );
                              },
                            ),
                          ],
                        ),
                      )),
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (viewModel) => viewModel.getInfo());
  }
}

class _TodayPrice extends StatelessWidget {
  final HomeViewModel model;

  const _TodayPrice({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.38,
      color: Colors.blue,
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Today',
                  style: TextStyle(fontSize: 35.0, color: Colors.white)),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SvgPicture.network(
                        model.bitcoinModel!.logoUrl,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(height: 20.0),
                      Text(model.bitcoinModel!.name,
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Price (USD)',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                      model.refreshPriceState == NotifierState.loading
                          ? Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : Text(model.bitcoinModel!.price.split('.').first,
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white)),
                      SizedBox(height: 15.0),
                      Text('Rank: ${model.bitcoinModel!.rank.toString()}',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () => model.navToDetail(
                    context,
                    model.bitcoinModel!.priceDate.toString(),
                    model.bitcoinModel!.logoUrl),
                child: Text('More info',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )),
              )
            ],
          )),
    );
  }
}

class _LastWeeksPrice extends StatelessWidget {
  final String date;
  final String price;
  final String logoUrl;

  const _LastWeeksPrice(
      {Key? key,
      required this.logoUrl,
      required this.date,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(date.split(' ').first.toString()),
            subtitle: Text('${price.split('.').first.toString()} USD'),
            leading: SvgPicture.network(
              logoUrl,
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
