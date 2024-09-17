import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4f_challenge_app/model/item_model.dart';
import 'package:t4f_challenge_app/repository/colors.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';

class ItemDetailsScreen extends StatefulWidget {
  final ItemModel model;

  const ItemDetailsScreen({required this.model, super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${widget.model.title}'),
              ],
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            clipBehavior: Clip.antiAlias,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Hero(
                    tag: "${widget.model.id}",
                    child: CachedNetworkImage(
                      imageUrl: '${widget.model.image}?id=${widget.model.id}',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: Icon(Icons.image, size: 48)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: kMinInteractiveDimension * 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor.withOpacity(1),
                          AppColors.primaryColor.withOpacity(.8),
                          AppColors.primaryColor.withOpacity(.6),
                          AppColors.primaryColor.withOpacity(0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: context.watch<HomeViewModel>().isDarkMode
                            ? Colors.black.withOpacity(.3)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.model.title} details:',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.grey.withOpacity(.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      for (int i = 0; i < widget.model.details.length; i++)
                        TableRow(
                          decoration: BoxDecoration(
                            color: i % 2 == 1 ? AppColors.primaryColor.withOpacity(.15) : Colors.transparent,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.model.details[i].$1}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: widget.model.details[i].$1 == 'URL'
                                  ? InkWell(
                                      onTap: () {},
                                      child: Text(
                                        '${widget.model.details[i].$2}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.linkTextColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      '${widget.model.details[i].$2}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
