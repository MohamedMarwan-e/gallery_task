import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_task/controller/search_provider.dart';
import 'package:gallery_task/core/helper/colors.dart';
import 'package:gallery_task/data/models/search_model.dart';
import 'package:gallery_task/view/screens/image_screen.dart';
import 'package:gallery_task/view/widgets/custom_image.dart';
import 'package:gallery_task/view/widgets/custom_text.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>  {
  PagingController<int, Photo> pagingController = PagingController(firstPageKey: 1);
  TextEditingController  searchController = TextEditingController();
  final int pageSize = 1;
  bool servicesLoader = false;
  SearchModel? searchModel;


  Future<void> servicesFuture({String? searchKeyword, int? perPage, int? pageKey}) async {
    servicesLoader = true;
    try {
      var data =await Provider.of<SearchProvider>(context, listen: false).getSearch(query: searchKeyword!, perPage: perPage!,page:pageKey! );
      if (data != null) {
        List<Photo> adds = data.photos!;
        if (pageKey == 1) {
          pagingController.itemList = [];
        }
        final isLastPage = adds.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(adds);
        } else {
          final nextPageKey = pageKey + 1 ;
          pagingController.appendPage(adds, nextPageKey);
        }
      }
      servicesLoader = false;
    } catch (e) {
      servicesLoader = false;
      rethrow;
    }
  }


  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<SearchProvider>(context);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: CustomText(
          text:  "Search",
          color: MyColors.primary,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child:  Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal
                    ),
                    obscureText:false,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor:MyColors.primary,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      if(searchController.text.isNotEmpty){
                          servicesFuture(searchKeyword:searchController.text,perPage: 6,pageKey: 1);
                          pagingController.addPageRequestListener((pageKey) {
                            servicesFuture(pageKey: pageKey,searchKeyword:searchController.text,perPage: 6);
                          });

                      }else{}
                      },
                    decoration:  InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      hoverColor: MyColors.primary,
                      focusColor: MyColors.primary,
                      prefixIcon: Icon(Icons.search,color:MyColors.primary,size:20),
                      suffixIcon: IconButton(
                          onPressed: (){
                            searchController.clear();
                          },
                          icon:  Icon(FontAwesomeIcons.timesCircle,color:MyColors.primary,size: 16,)
                      ),
                      hintText: "search",
                      hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12),
                      filled: true,
                      fillColor:  const Color.fromRGBO(240, 240, 240, 1),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(240, 240, 240, 1),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(240, 240, 240, 1),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter data";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

              ],
            ),
          ),
        ) ,
      ),
      body: ref.searchModel != null ?
      servicesLoader ?
       const Center(child: CircularProgressIndicator()):
      SafeArea(
        child: PagedGridView<int, Photo>(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          pagingController: pagingController,
          padding: const EdgeInsets.only(bottom: 30),
          shrinkWrap: true,
          builderDelegate: PagedChildBuilderDelegate<Photo>(
              noItemsFoundIndicatorBuilder: (context) => const Center(child: Text('No Item Found')),
              firstPageProgressIndicatorBuilder: (_) => const SizedBox.shrink(),
              itemBuilder: (context, item, index) => SizedBox(
                width: media.width ,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDetailScreen(image: item.src!.large,id: item.id)));
                  },
                  child: CustomImage(
                    item.src!.large!,
                    horizontal: media.width * 0.02,
                    radius: 10,
                    isShadow: true,
                  ),
                ),
              )
          ),
        ),
      ):const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

