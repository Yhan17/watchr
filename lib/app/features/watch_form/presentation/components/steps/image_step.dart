import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../../core/presentation/shared/widgets/watch_button_text_outlined_widget.dart';
import '../../notifiers/watch_form_state_notifier.dart';
import '../../routes/watch_form_routes.dart';
import '../default_form_scaffold.dart';

class ImageStep extends HookConsumerWidget {
  const ImageStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = useState<File?>(null);
    final editImagePath = useState<String?>(null);
    final watchFormStateNotifier = ref.watch(
      watchFormStateNotifierProvider.notifier,
    );
    final imageCanContinue = ref.watch(
      watchFormStateNotifierProvider.select((value) => value.imageCanContinue),
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (watchFormStateNotifier.last.editEntity != null) {
          editImagePath.value =
              watchFormStateNotifier.last.editEntity!.imageStoragePath;
        }
      });
      return null;
    }, const []);

    return DefaultFormScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: _renderImage(
            file,
            watchFormStateNotifier,
            editImagePath,
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(52),
        ),
        SliverToBoxAdapter(
          child: Text(
            'What time is it?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(32),
        ),
        SliverToBoxAdapter(
          child: Text(
            'insert an image of your watch adn we will do the rest',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
      bottomBarWidget: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              bottom: 32,
            ),
            child: WatchButtonTextOutlinedWidget(
              onTap: imageCanContinue || editImagePath.value != null
                  ? () {
                      WatchFormRoutes.nameStep.push(
                        context,
                        arguments: noArgs,
                      );
                    }
                  : null,
              text: 'Next',
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderImage(
    ValueNotifier<File?> file,
    WatchFormStateNotifier watchFormStateNotifier,
    ValueNotifier<String?> editImagePath,
  ) {
    if (editImagePath.value != null) {
      return Stack(
        children: [
          Center(
            child: Image.network(
              editImagePath.value!,
              height: 300,
            ),
          ),
          Positioned(
            right: 24,
            top: 24,
            child: GestureDetector(
              onTap: () {
                editImagePath.value = null;
                file.value = null;
              },
              child: const Icon(
                Icons.delete,
                color: AppColors.darkOrange,
              ),
            ),
          )
        ],
      );
    }

    if (file.value != null) {
      return Stack(
        children: [
          Center(
            child: Image.file(
              file.value!,
              height: 300,
            ),
          ),
          Positioned(
            right: 24,
            top: 24,
            child: GestureDetector(
              onTap: () {
                editImagePath.value = null;
                file.value = null;
              },
              child: const Icon(
                Icons.delete,
                color: AppColors.darkOrange,
              ),
            ),
          )
        ],
      );
    }

    return GestureDetector(
      onTap: () async {
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          file.value = File(image.path);
          watchFormStateNotifier.imageChange(file.value!);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(122),
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ).copyWith(top: 64),
        decoration: const BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.photo_rounded,
            color: AppColors.brownLight,
            size: 64,
          ),
        ),
      ),
    );
  }
}
