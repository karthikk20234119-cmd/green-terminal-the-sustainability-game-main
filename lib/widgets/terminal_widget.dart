import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

class TerminalWidget extends StatefulWidget {
  final String text;
  final bool showCursor;
  final VoidCallback? onComplete;
  final Duration typingSpeed;
  final bool autoStart;
  
  const TerminalWidget({
    Key? key,
    required this.text,
    this.showCursor = true,
    this.onComplete,
    this.typingSpeed = AppConstants.typingSpeed,
    this.autoStart = true,
  }) : super(key: key);

  @override
  State<TerminalWidget> createState() => _TerminalWidgetState();
}

class _TerminalWidgetState extends State<TerminalWidget>
    with TickerProviderStateMixin {
  late AnimationController _cursorController;
  late AnimationController _glowController;
  
  @override
  void initState() {
    super.initState();
    
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppTheme.matrixGreen.withOpacity(0.1 + (_glowController.value * 0.1)),
                blurRadius: 10 + (_glowController.value * 5),
                spreadRadius: 1,
              ),
            ],
          ),
          child: AnimatedTextKit(
            key: ValueKey(widget.text),
            animatedTexts: [
              TypewriterAnimatedText(
                widget.text,
                textStyle: AppTheme.terminalOutput,
                speed: widget.typingSpeed,
                cursor: widget.showCursor ? '█' : '',
              ),
            ],
            totalRepeatCount: 1,
            onFinished: widget.onComplete,
            displayFullTextOnTap: true,
          ),
        );
      },
    );
  }

}

class TerminalPrompt extends StatelessWidget {
  final String prompt;
  final Widget? child;
  
  const TerminalPrompt({
    Key? key,
    this.prompt = AppConstants.systemPrompt,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prompt,
          style: AppTheme.terminalPrompt,
        ),
        if (child != null) Expanded(child: child!),
      ],
    );
  }
}

class TerminalLine extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool showPrompt;
  
  const TerminalLine({
    Key? key,
    required this.text,
    this.style,
    this.showPrompt = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? AppTheme.terminalOutput;
    
    if (showPrompt) {
      return TerminalPrompt(
        child: Text(text, style: textStyle),
      );
    }
    
    return Text(text, style: textStyle);
  }
}

class TerminalButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  
  const TerminalButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<TerminalButton> createState() => _TerminalButtonState();
}

class _TerminalButtonState extends State<TerminalButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: widget.isSelected 
                  ? AppTheme.darkGreen.withOpacity(0.3)
                  : (_isHovered ? AppTheme.matrixGreen.withOpacity(0.1) : Colors.transparent),
              border: Border.all(
                color: _isHovered || widget.isSelected 
                    ? AppTheme.matrixGreen
                    : AppTheme.darkGreen,
                width: _isHovered ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      '> ',
                      style: AppTheme.terminalPrompt.copyWith(
                        color: _isHovered || widget.isSelected 
                            ? AppTheme.matrixGreen 
                            : AppTheme.darkGreen,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.text,
                        style: AppTheme.terminalCommand.copyWith(
                          color: _isHovered || widget.isSelected 
                              ? AppTheme.lightGreen 
                              : AppTheme.matrixGreen,
                        ),
                      ),
                    ),
                    if (_isHovered || widget.isSelected)
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppTheme.matrixGreen,
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }
}

class MatrixBackground extends StatefulWidget {
  final Widget child;
  
  const MatrixBackground({Key? key, required this.child}) : super(key: key);

  @override
  State<MatrixBackground> createState() => _MatrixBackgroundState();
}

class _MatrixBackgroundState extends State<MatrixBackground>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<MatrixDrop> _drops;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    )..repeat();
    
    _drops = List.generate(
      AppConstants.matrixDropCount,
      (index) => MatrixDrop(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Matrix drops background
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return CustomPaint(
              painter: MatrixPainter(_drops),
              size: Size.infinite,
            );
          },
        ),
        // Main content
        widget.child,
      ],
    );
  }
}

class MatrixDrop {
  double x = 0;
  double y = 0;
  double speed = 1;
  List<String> characters = [];
  
  MatrixDrop() {
    reset();
  }
  
  void reset() {
    final random = DateTime.now().microsecondsSinceEpoch;
    x = (random % 1000) / 1000;
    y = -0.1;
    speed = 0.5 + (random % 500) / 1000;
    characters = List.generate(10, (index) => _getRandomChar(random + index));
  }
  
  String _getRandomChar(int seed) {
    const chars = '01アカサタナハマヤラワ';
    return chars[(seed) % chars.length];
  }
  
  void update() {
    y += speed * 0.01;
    if (y > 1.1) {
      reset();
    }
  }
}

class MatrixPainter extends CustomPainter {
  final List<MatrixDrop> drops;
  
  MatrixPainter(this.drops);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    for (var drop in drops) {
      drop.update();
      
      for (int i = 0; i < drop.characters.length; i++) {
        final opacity = (1.0 - (i / drop.characters.length)) * 0.3;
        paint.color = AppTheme.matrixGreen.withOpacity(opacity);
        
        final textPainter = TextPainter(
          text: TextSpan(
            text: drop.characters[i],
            style: TextStyle(
              color: paint.color,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            drop.x * size.width,
            (drop.y - i * 0.02) * size.height,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
