import 'package:flutter/widgets.dart';

const _kBtcLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/3840px-Bitcoin.svg.png";

class CashSendBackgroundPattern extends StatelessWidget {
  const CashSendBackgroundPattern({super.key, this.offset = Offset.zero});

  final Offset offset;

  static const _overflowFactor = 1.4;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRect(
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (rect) => const RadialGradient(
            center: Alignment.center,
            radius: 0.65,
            colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
            stops: [0.1, 0.85],
          ).createShader(rect),
          child: AnimatedSlide(
            offset: offset,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOut,
            child: Opacity(
              opacity: 0.05,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth * _overflowFactor;
                  final height = constraints.maxHeight * _overflowFactor;

                  return OverflowBox(
                    maxWidth: width,
                    maxHeight: height,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                        itemCount: 160,
                        itemBuilder: (context, index) =>
                            Image.network(_kBtcLogo, fit: BoxFit.contain),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
