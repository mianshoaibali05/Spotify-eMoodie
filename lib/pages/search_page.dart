
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/data/models/album_model.dart';
import 'package:spotify/data/models/artist_model.dart';
import '../controllers/search_controller.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpotifySearchController>(
      init: SpotifySearchController(),
        builder: (_){
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent,),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                      child: Text('Search', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600),)),
                  SizedBox(height: 16,),
                  CupertinoSearchTextField(
                    controller: _.searchEditingController,
                    placeholder: 'Artist, albums...',
                    placeholderStyle: TextStyle(color: Colors.black, fontSize: 14),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    onSubmitted: (value) => _.callApis(),
                    onSuffixTap: () => _.onSuffixClick(),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                  SizedBox(height: 16,),
                  if(_.albumsList.isNotEmpty || _.artistsList.isNotEmpty)Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0, // Spacing between chips
                      children: List<Widget>.generate(
                        _.chipLabels.length,
                            (index) {
                          return ChoiceChip(
                            label: Text(_.chipLabels[index]),
                            selected: _.selectedIndex == index,
                            onSelected: (bool selected) {
                              _.switchChip(newValue: index);
                              //_selectedIndex = selected ? index : null;
                            },
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Rounded corners
                              side: BorderSide(
                                color: Colors.white24,
                                width: 1.0,
                              ),
                            ),
                            selectedColor: Colors.green,
                            backgroundColor: Colors.black,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(height: 16,),
                  _.selectedIndex == 0 ? Expanded(
                    child: GridView.builder(
                      itemCount: _.albumsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 10, // Spacing between columns
                          mainAxisSpacing: 10, // Spacing between rows
                          childAspectRatio: 1.0, // Width-to-height ratio of each grid item
                        ),
                        itemBuilder: (context, index){
                        AlbumModel album = _.albumsList[index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 116,
                                width: MediaQuery.of(context).size.width,
                                child: album.images.isNotEmpty ? FadeInImage(
                                  height: 116,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                  imageErrorBuilder: (context,
                                      exception, stackTrace) {
                                    return Image.asset(
                                      fit: BoxFit.fill,
                                      "assets/icons/ic_launcher.png",);
                                  },
                                  placeholder: const AssetImage("assets/icons/ic_launcher.png"),
                                  image: NetworkImage(album.images.first.url,),
                                ) : Image.asset(
                                  fit: BoxFit.fill,
                                  "assets/icons/ic_launcher.png",),
                              ),
                              SizedBox(height: 8,),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(album.name, maxLines: 1, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),)),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(album.getArtistsName, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500),)),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(album.releaseDate, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500),)),
                            ],
                          );
                        }),
                  ) :
                  Expanded(
                    child: ListView.separated(
                        itemCount: _.artistsList.length,
                        itemBuilder: (context, index){
                          ArtistModel artist = _.artistsList[index];
                          return Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: artist.images.isNotEmpty ? FadeInImage(
                                    height: 50,
                                    width: 50,
                                    imageErrorBuilder: (context,
                                        exception, stackTrace) {
                                      return Image.asset(
                                        fit: BoxFit.fill,
                                        "assets/icons/ic_launcher.png",);
                                    },
                                    placeholder: const AssetImage("assets/icons/ic_launcher.png"),
                                    image: NetworkImage(artist.images.first.url),
                                  ) : Image.asset(
                                    fit: BoxFit.fill,
                                    "assets/icons/ic_launcher.png",),
                                ),
                              ),
                              SizedBox(width: 12,),
                              Text(artist.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),
                            ],
                          );
                        },
                      separatorBuilder: (context, index){
                          return SizedBox(height: 16,);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}