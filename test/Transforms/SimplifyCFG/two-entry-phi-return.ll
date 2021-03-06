; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -simplifycfg -S | FileCheck %s

define i1 @qux(i8* %m, i8* %n, i8* %o, i8* %p) nounwind  {
; CHECK-LABEL: @qux(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP7:%.*]] = icmp eq i8* %m, %n
; CHECK-NEXT:    [[TMP15:%.*]] = icmp eq i8* %o, %p
; CHECK-NEXT:    [[TMP15_:%.*]] = select i1 [[TMP7]], i1 [[TMP15]], i1 false, !prof !0
; CHECK-NEXT:    ret i1 [[TMP15_]]
;
entry:
  %tmp7 = icmp eq i8* %m, %n
  br i1 %tmp7, label %bb, label %UnifiedReturnBlock, !prof !0

bb:
  %tmp15 = icmp eq i8* %o, %p
  br label %UnifiedReturnBlock

UnifiedReturnBlock:
  %result = phi i1 [ 0, %entry ], [ %tmp15, %bb ]
  ret i1 %result

}

!0 = !{!"branch_weights", i32 4, i32 64}
