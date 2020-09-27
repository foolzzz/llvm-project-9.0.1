; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

; Div/rem by zero is undef.

define i32 @srem0(i32 %x) {
; CHECK-LABEL: srem0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %rem = srem i32 %x, 0
  ret i32 %rem
}

define i32 @urem0(i32 %x) {
; CHECK-LABEL: urem0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %rem = urem i32 %x, 0
  ret i32 %rem
}

define i32 @sdiv0(i32 %x) {
; CHECK-LABEL: sdiv0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %div = sdiv i32 %x, 0
  ret i32 %div
}

define i32 @udiv0(i32 %x) {
; CHECK-LABEL: udiv0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %div = udiv i32 %x, 0
  ret i32 %div
}

; Div/rem by zero vectors is undef.

define <4 x i32> @srem_vec0(<4 x i32> %x) {
; CHECK-LABEL: srem_vec0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %rem = srem <4 x i32> %x, zeroinitializer
  ret <4 x i32> %rem
}

define <4 x i32> @urem_vec0(<4 x i32> %x) {
; CHECK-LABEL: urem_vec0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %rem = urem <4 x i32> %x, zeroinitializer
  ret <4 x i32> %rem
}

define <4 x i32> @sdiv_vec0(<4 x i32> %x) {
; CHECK-LABEL: sdiv_vec0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %div = sdiv <4 x i32> %x, zeroinitializer
  ret <4 x i32> %div
}

define <4 x i32> @udiv_vec0(<4 x i32> %x) {
; CHECK-LABEL: udiv_vec0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %div = udiv <4 x i32> %x, zeroinitializer
  ret <4 x i32> %div
}

; Make sure we handle undef before we try to fold constants from the select with the 0.
; These used to assert because we can't fold div/rem-by-0 into APInt.

define i32 @sel_urem0(i1 %cond) {
; CHECK-LABEL: sel_urem0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, i32 23, i32 234
  %rem = urem i32 %sel, 0
  ret i32 %rem
}

define i32 @sel_srem0(i1 %cond) {
; CHECK-LABEL: sel_srem0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, i32 23, i32 234
  %rem = srem i32 %sel, 0
  ret i32 %rem
}

define i32 @sel_udiv0(i1 %cond) {
; CHECK-LABEL: sel_udiv0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, i32 23, i32 234
  %div = udiv i32 %sel, 0
  ret i32 %div
}

define i32 @sel_sdiv0(i1 %cond) {
; CHECK-LABEL: sel_sdiv0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, i32 23, i32 234
  %div = sdiv i32 %sel, 0
  ret i32 %div
}

; Make sure we handle undef before we try to fold constants from the select with the vector 0.
; These used to assert because we can't fold div/rem-by-0 into APInt.

define <4 x i32> @sel_urem0_vec(i1 %cond) {
; CHECK-LABEL: sel_urem0_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, <4 x i32> <i32 -1, i32 0, i32 1, i32 2>, <4 x i32> <i32 11, i32 12, i32 13, i32 14>
  %rem = urem <4 x i32> %sel, zeroinitializer
  ret <4 x i32> %rem
}

define <4 x i32> @sel_srem0_vec(i1 %cond) {
; CHECK-LABEL: sel_srem0_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, <4 x i32> <i32 -1, i32 0, i32 1, i32 2>, <4 x i32> <i32 11, i32 12, i32 13, i32 14>
  %rem = srem <4 x i32> %sel, zeroinitializer
  ret <4 x i32> %rem
}

define <4 x i32> @sel_udiv0_vec(i1 %cond) {
; CHECK-LABEL: sel_udiv0_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, <4 x i32> <i32 -1, i32 0, i32 1, i32 2>, <4 x i32> <i32 11, i32 12, i32 13, i32 14>
  %div = udiv <4 x i32> %sel, zeroinitializer
  ret <4 x i32> %div
}

define <4 x i32> @sel_sdiv0_vec(i1 %cond) {
; CHECK-LABEL: sel_sdiv0_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %sel = select i1 %cond, <4 x i32> <i32 -1, i32 0, i32 1, i32 2>, <4 x i32> <i32 11, i32 12, i32 13, i32 14>
  %div = sdiv <4 x i32> %sel, zeroinitializer
  ret <4 x i32> %div
}

; If any element of a constant divisor vector is zero, the whole op is undef.

define <4 x i32> @sdiv0elt_vec(<4 x i32> %x) {
; CHECK-LABEL: sdiv0elt_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %zero = and <4 x i32> %x, <i32 0, i32 0, i32 0, i32 0>
  %some_ones = or <4 x i32> %zero, <i32 0, i32 -1, i32 0, i32 3>
  %div = sdiv <4 x i32> <i32 -11, i32 -12, i32 -13, i32 -14>, %some_ones
  ret <4 x i32> %div
}

define <4 x i32> @udiv0elt_vec(<4 x i32> %x) {
; CHECK-LABEL: udiv0elt_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %div = udiv <4 x i32> <i32 11, i32 12, i32 13, i32 14>, <i32 0, i32 3, i32 4, i32 0>
  ret <4 x i32> %div
}

define <4 x i32> @urem0elt_vec(<4 x i32> %x) {
; CHECK-LABEL: urem0elt_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %zero = and <4 x i32> %x, <i32 0, i32 0, i32 0, i32 0>
  %some_ones = or <4 x i32> %zero, <i32 0, i32 0, i32 0, i32 3>
  %rem = urem <4 x i32> <i32 11, i32 12, i32 13, i32 14>, %some_ones
  ret <4 x i32> %rem
}

define <4 x i32> @srem0elt_vec(<4 x i32> %x) {
; CHECK-LABEL: srem0elt_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %rem = srem <4 x i32> <i32 -11, i32 -12, i32 -13, i32 -14>, <i32 -3, i32 -3, i32 0, i32 2>
  ret <4 x i32> %rem
}

