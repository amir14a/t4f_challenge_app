import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4f_challenge_app/model/item_model.dart';
import 'package:t4f_challenge_app/repository/colors.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel model;
  final VoidCallback onTap;

  const ItemWidget({required this.model, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: SizedBox(
            height: 256,
            child: Stack(
              children: [
                Hero(
                  tag: "${model.id}",
                  child: Container(
                    width: 300,
                    height: 256,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: "${model.image}?id=${model.id}",
                      width: 300,
                      height: 256,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      placeholder: (context, url) => const Center(child: Icon(Icons.image, size: 48)),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: context.watch<HomeViewModel>().isDarkMode ? Colors.black.withOpacity(.3) : Colors.transparent,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.6),
                          Colors.black.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.title ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: context.watch<HomeViewModel>().isDarkMode
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.monetization_on,
                            color: Colors.green,
                          ),
                          Text(
                            '\$${model.price}',
                            style: const TextStyle(fontSize: 14, color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
