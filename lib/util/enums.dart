import 'package:flutter/material.dart';
import 'package:invoice_app/styles/colors.dart';

enum EPaymentState {
  unpaid("UNPAID", 0),
  paid("PAID", 1),
  partially("PARTIALLY", 2),
  overdue("OVERDUE", 3);

  final String paymentStateTitle;
  final int paymentStateIndex;
  const EPaymentState(this.paymentStateTitle, this.paymentStateIndex);
}

Color paymentStateReturnColor(EPaymentState status) {
  switch (status) {
    case EPaymentState.unpaid:
      return AppPaymentStateColor.unpaidColor;
    case EPaymentState.paid:
      return AppPaymentStateColor.paidColor;
    case EPaymentState.partially:
      return AppPaymentStateColor.partiallyColor;
    case EPaymentState.overdue:
      return AppPaymentStateColor.overdueColor;
  }
}
