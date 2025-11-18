import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';
import 'package:vakilium/src/common/widgets/app_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topLeft,
    child: PointerInterceptor(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: context.color.white, borderRadius: Dimension.rAll20),

              child: Padding(
                padding: Dimension.pAll16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: context.color.gray200),
                        borderRadius: Dimension.rAll12,
                      ),
                      child: Padding(
                        padding: Dimension.pAll16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Вызвать юриста',
                              style: context.textTheme.interW600s16.copyWith(color: context.color.gray900),
                            ),
                            Dimension.hBox16,
                            Divider(thickness: 1, height: 1, color: context.color.gray100),
                            Dimension.hBox16,
                            Row(
                              children: [
                                Assets.icons.location.svg(width: 40, height: 40),
                                Dimension.wBox12,
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Точка вызова юриста',
                                        style: context.textTheme.interW400s14.copyWith(color: context.color.gray400),
                                      ),
                                      Text(
                                        'Москва',
                                        style: context.textTheme.interW400s18.copyWith(color: context.color.gray900),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Dimension.hBox16,
                    Text(
                      "Часто используемые услуги",
                      style: context.textTheme.interW600s16.copyWith(color: context.color.gray800),
                    ),
                    Dimension.hBox8,
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 4,
                      separatorBuilder: (_, _) => Dimension.hBox8,
                      itemBuilder: (context, index) => const ServiceTile(),
                    ),
                    Dimension.hBox16,
                    Text(
                      "Посмотреть все услуги",
                      style: context.textTheme.interW600s16.copyWith(color: context.color.gray800),
                    ),
                    Dimension.hBox16,
                    const AppButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ServiceTile extends StatelessWidget {
  const ServiceTile({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: context.color.gray200),
      borderRadius: Dimension.rAll12,
    ),
    padding: Dimension.pH16V8,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Radio(value: true),
        Dimension.wBox12,
        Expanded(
          child: Text(
            "Посещение клиентов в местах лишения свободые ",
            maxLines: 2,
            style: context.textTheme.interW400s16.copyWith(color: context.color.gray900),
          ),
        ),
      ],
    ),
  );
}
