import 'dart:async';

import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class OtpCountdownTimer extends StatefulWidget {
  const OtpCountdownTimer({super.key, required this.minutes});

  final int minutes;

  @override
  State<OtpCountdownTimer> createState() => _OtpCountdownTimerState();
}

class _OtpCountdownTimerState extends State<OtpCountdownTimer> {
  late Duration _duration;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    resetTimer();
    startTimer();
  }

  void resetTimer() {
    setState(() {
      _duration = Duration(minutes: widget.minutes);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final seconds = _duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        _duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            resetTimer();
            startTimer();
          },
          icon: Text(AppText.reSendOtpCode,
              style:
                  context.text.bodyMedium!.copyWith(color: AppColors.subText)),
        ),
        Text(
          '$minutes:$seconds',
          style: context.text.bodyMedium!.copyWith(color: AppColors.subText),
        ),
      ],
    );
  }
}
