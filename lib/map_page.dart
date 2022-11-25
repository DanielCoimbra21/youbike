import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'custom_drawer.dart';

//LINK API MAP : 'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
//flUTTER MAP :
//Polyline : B2F0hki4Cg164N81K4HwEU0UoVU4cnkBjDsOgPToVgZT8B8BAkIgKAwW0ZT8QgUTsEgFAwW8aTsEgFA8GkIAoL4NTwH0KT0FkIAwHwMTgKwRTwH4NTsEkIT7BwCATsEAA8BAUwCAwC4DAvCwHAvC0KA3D8QUzF0ZU3DoQUnBoGA7B8GAnBoGATsEAA4DAoBsEA8BgFToBwCA8BkDA8BwCT4DsEAoLsOnB4N8QnB8G4IToGsJTsE4IAwCoGA8B8GAwHwlBA8B4IAwCsOAkDsOAsE0PAsEwMAgFoLA8GwMAwM8QAsJoLAkNsOAwMkNA4c4cAkpCwoCA0PgPAgKgKAkIgKAwHsJAgF8GAwH0KA8G8LA0FgKA0FoLA8GoQAgF4NA4D0KA4DkNA4DsOAwCkNAwCgPAU0FAUgFA8B4XAUwWA8BkSAwCsTAkD8aAgFofA0K4_BAsd81FUoGokBA0Pw8CAkIwvBAUkDAgF8aAkIkhBAsEwRU4D0PAwCkNAoB8QAnBTAnBTAnBAA7BUAnBoBAnBoBAT8BAT8BAAoBAA8BAU8BAUoBAUoBAoBoBAoBUA8BUA8BTAoBTAoBnBAoB7BA0FkIA4DsJAkDsJAwC0KA4DgUA8BkIAsJgtBU4DkSAgFkXA4D8QA0FoVTgFwRAgFsOAwHsTAwMkcA8LoaAgP0eA4N0eAkNgZA4D8GAwlB4pCAgPofAwRgjBAkNkXAkNgUAoGgKAgFkIA0PwWAwM8QAsTsYA0tBs2BAgjBopBUgKoLAkSwWA4S8aAgUgeA0KwRAkNkXAwMoVA0PkcAkN0ZA8V8uBA0Zw5BA4S8pBAwWw0BU8QkmBAsOsiBA0PopBA8LkhBA4SgyBAoVs2BAoV8zBAwCoGAkD8GA8GoQAsOsiBA0yBk2DAsYk6BUoQsnBA0FwMA4D4IA4D4IA0F0KAoG0KAwH8LA0FgKAwHgPAsEoLAkI8VA4NwlBAgKwbA4NwlBAkIkXAkI8VA8BgFA8LkhBAsJoaAgKkcA0F4SAsEsOAoGgZAoGkXAwH0jBUgKk6BAoV8jEAoBwHAkN8xCAUwHAoBwHAoB8LAwCwRAsJ4wBAwM0rCAwRguDA4Ik1BA0FgeUsJsnBA0FgUAoGoVAsO8pBAoLgjBAgKsdA8L4hBA8Q0tBAoV03BU0F0PA4IkXAoQopBAkS4rBA0FkNAgF0KAwH0PAkDoGAgFsJA8QkhBA4SgjBAoVwlBAwRwbA0yB8xCAgFwHAwH8LA8L4SAsEwHA4rBslCAslCguDU8aopBA4S0eA0KgUAoGoLA0K8VA4IwRAoGsOAwHsTAsE8QAkDwRAwCgPAwCkSAoB8LAUsOUUsOAUwRUwC0oBToBgeT8BwoCAkDgkDUkD8sCAoBwqBAA4wBA7Bs2BA3DkrBAvMwhDAvHo9BAvCwgBAjD4_BAnBokBAAozBAwC08BAoBwWAkD8VAsEwWUkN8zBAoVg1CA0FoaAgPk_BUkI0eAgUk_BAwbsqCA0PwqBAkhB0wCAofwyCUgZ08BA8fwoCA4SkrBA8LofAgF0PA8VkkCAsdo7CUwvBoyEAgUo9BA8a4zCU0ZwyCAwH8VAwC0FA8BkDA8BwCATsEATgFAoBoGA8G0PAsJwRAkI4NAsOwWAgKwRA4IsTA4IoaA8L0jBAkNkrBA0P0yBA8VwtCAgP4rBAkI4XAgPk6BAkIkcAwMkmBToLgeA4hBs5CAoG8QAkIwWA8Vk6BA4NkmBAsTw0BAoaslCAgFkNAgK8aAoGkSAkc8sCA0U03BAkX89BAsE8LAgKoaUsJoVAgFgKAkIkNA4DgFAoLsOUsJgKAwHwHAgP8LA0PsJA0F4DAnBgFAAkDAU4DA8BwCA8BoBA4DTA4DnBA0FvCA0FTAsEUA4DUA4DUAwCnBAoBjDAUzFATrEA7BjDA8BjDAsE_EA8V7QA0erYTgKjIAgenVAoG_EA4InGAoGjDAUkDA8BkDAwC8BAkDUAwCTA8B7BA8B3DAUrEAnB_EA7BjDUvC7BA8BnLA8BrJA8BjIAgFrTU4D7LU8BzFAgFnQAgK7fAgKrdT8BzFAoBUA8BAA8BnBAoB7BAUvCAAvCATvCAnB7BAnBnBAwC3IAkDvMU4DvWUoB7VATvMU7BnQUnG_YU_ErTUvC_OUnB3NUA_JAoBnLU8B7GA8BvHTwCzFAkDnGA4D7GA4D_EAoGvHAkSnQT0PjNAoL4XAwWgoBAkD0FA0yBk9C7B0FsJTsE0FA8BwCAsEgFATkDAU8BAoBoBAoBAAoBAAsEoGTgKgPA8Q4SToVsTT4DkDA0UoQT4N4IAoQoLAkN4IT0PgKATkDAU4DAoBkDAwC8BAkDUAkDnBA8BvCA8V0PAkmB8aUoVoQUgeoVA8V4SU89Bw5BoBsY8QAgZoVA8pBgjBAwMgKA0KwHA8GkDAsJ8BA7B8BAnBkDATkDAUsEA8B4DAkD8BA4DAAwCvCA0K8QAoLoQT4I4SAkXofAgZwgBT41Bk6BToLkNAkS0UA0PkSA4N8QA4S4XAsd4rBU0KoQA0KkSU4NsYAoVwqBUoao4BAwRsnBAkIwRAkIgUA8QkrBT0KgjBAgKwgBA0F4XA4IsnBAoLghCAwHwvBA4DwWAkD0PAsEoaAkDgUAsJ41BAkI8kBAkIwgBAwHoaA4IkcAsJwgBAwWonCAwbwhDAkSoiCTkSoiCA0K4mBAsJ4hBAoL0oBA4DwMA0Pk6BAsOozBAkNsxBAgK0jBA8G0ZAoL0oBAkDoLAgFwRA0FwWUkI4hBA0F0ZAoL4_BUwMkpCUgFkcAkIwqBU4DoQA4D4NAwHwbAsE0PAsE4NAsEkNAgFkNATwCAAwCAUwCAoBwCA8BwCA8BoBAwCAAkD8GUgKsTA8LkcUgKgZAkI4XAoG4SAoGgZUgF8aA4D8VUwCoQA4DsYUoB0KA8B0PUwHgyBoB0FokBU4DoaUUgFA4DwWAsE8aAoB4IAoBkIAkDkXA4DkXTsE8fTwCoVT8B8VTU4SAU0UAoB0yBTU4XAUkNAA4NAAsTToB8QAkDsdA4DsTAsEkXTgFgUA8BkIAwHgeT0FkXA8GwqBA4DgeA4DwbT8BsOA8B4SAgFkmBAsEsdAsE8VAkDoQAsEoVA8GoaA0FoQAsEwMA4XonCAopBg4DUge82CAk1Bs6EAs7B0qFUgtBojEA0oBo0DU0Z0rCA0ZsqCA8G4SA8G0UA8LgjBUkN4mBA4Sk1BAkc8xCAsO8pBAwbgwCUwlBksDA0P8uBU4N0jBAgFwMA0F8LAokBgwCUkX0yBAwMsYAgPgeA8QwbUwMoVAwH0PAgKgZUoLokBAkDoLAkDgKAsOgyBU8VkuCUgFoVA0FwWAoQwjCUsJgoBAwHsdAsOghCA8kBs6EUkhBgiEAgP41BUsY4zCA8BoGA0KsnBA4Xw3CAgFwRA8GgZAgKokBUwWgwCAwRk_BU8V8sCU4NkwBA4IkcAkI0ZUsEwMA4DgKAsE0KAoL4XU8QokBUgKkXAwHsTU0FwRA8L4rBUwHsdAgKsnBA4D0PAoL4rBA8LwvBA0K4rBAoG0ZAoGwbA4DwWTsE4cA4D8fA4D4hBTgF0jBAsJkmBA4IkhBAgK0jBAgUsqCAwMkrBT8L0oBA8LkmBA0Pk1BAkIsiBTwC4IA0F8VAgFwRAwCsJA0KgjBAsO0tBAsT08BAoV4kCAkc44CA8G4XA0UsgCU4IoaAwHsYAwHkXAgF0PAoGkSA0KwbAkNgeAgPofTwH4NAkDoGA0K4SA4IsOA0K8QAkDgFA4IkNA0Z4mBA4NkXAsEwHAjDoGAnBkITA4IAwCkIA4DsEAgFkDAgFoBUgFnBAsEjDAwCjDA4DoGAwM4SU0K0PUkkCgpDkD8GoLU0F0KUnBwCAnBkDAA4DAUkDAoBwCA8B8BAwCUA8BAA8BnBA8BnBAoGgKU4DoGAoGgKAsJ4SU8B4DAoGoLU4cozBoB0FgKUkSkhBUwMwWUgUokBU4IsOUwCsEUwCgFAsJwRUwMkXU8QwgBoBoVkmB8B0KsTUoQ4coBgFkIAsE8GUkD0FA4IoQUsJoQUwHgKUgF4DA4I4DAnBwCATwCAAwCAU8BAU8BAoB8BA8BoBA4DkNAoG8LToLsTToL4SAofs2B7B4IsOTwM4SAsOoVAoVsYAkSgUAwCwCAkSkSAgU0UA8LsOAgKkNAkIkNUsO4cA0FwMA4DsOAkD8LA0FofToBkIAsEsYT4DoQTsJsdnBsO41B7B0F0UToBgFAwM0tBTkD0KAoLsnBT8GkcA4IkcAkI4cUwMkmB8BkD0FA8BwCUwCUAkDTAsJ7GA0KjIUoQnLU8BwCAwCoBUwCTA8BjDAU3DAT3DAgF3DA4IzFU4wBwgB8B_EwMAnQgZTtEwFT

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var url =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      drawer: CustomDrawer(),
      body: Center(
        child: Container(
          child: Column(children: [
            Flexible(
                child: FlutterMap(
              options: MapOptions(
                center: LatLng(46.283099, 7.539069),
                zoom: 15,
              ),
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
                Container(
                  child: FloatingActionButton(
                    onPressed: () {
                      if (url ==
                          'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg') {
                        setState(() {
                          url =
                              'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg';
                        });
                      } else {
                        setState(() {
                          url =
                              'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
                        });
                      }
                    },
                    child: const Icon(Icons.map),
                  ),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(20),
                ),
              ],
              mapController: MapController(),
              children: [
                TileLayer(
                  urlTemplate: url,
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [
                        LatLng(46.1721198306801, 7.22284290898798),
                        LatLng(46.294661523787006, 7.534236631629828),
                        LatLng(46.94579954609295, 7.45244183275721),
                      ],
                      strokeWidth: 5,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            )),
          ]),
        ),
      ),
    );
  }
}
