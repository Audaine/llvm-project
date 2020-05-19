; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

declare void @use(i32 %x)

define void @test_01(i32 %x, i32 %y) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C2:%.*]] = icmp slt i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[C2]], label [[EXIT:%.*]], label [[UNREACHED:%.*]]
; CHECK:       unreached:
; CHECK-NEXT:    [[C1:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[COMPARATOR:%.*]] = zext i1 [[C1]] to i32
; CHECK-NEXT:    call void @use(i32 [[COMPARATOR]])
; CHECK-NEXT:    unreachable
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %c1 = icmp eq i32 %x, %y
  %c2 = icmp slt i32 %x, %y
  %signed = select i1 %c2, i32 -1, i32 1
  %comparator = select i1 %c1, i32 0, i32 %signed
  br i1 %c2, label %exit, label %unreached

unreached:
  call void @use(i32 %comparator)
  unreachable

exit:
  ret void
}


; TODO: %comparator and %signed can be sunk down to unreachable just as in
; test above.
define void @test_02(i32 %x, i32 %y) {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C1:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[C2:%.*]] = icmp slt i32 [[X]], [[Y]]
; CHECK-NEXT:    [[SIGNED:%.*]] = select i1 [[C2]], i32 -1, i32 1
; CHECK-NEXT:    [[COMPARATOR:%.*]] = select i1 [[C1]], i32 0, i32 [[SIGNED]]
; CHECK-NEXT:    br i1 [[C2]], label [[EXIT:%.*]], label [[MEDIUM:%.*]]
; CHECK:       medium:
; CHECK-NEXT:    [[C3:%.*]] = icmp sgt i32 [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[C3]], label [[EXIT]], label [[UNREACHED:%.*]]
; CHECK:       unreached:
; CHECK-NEXT:    call void @use(i32 [[COMPARATOR]])
; CHECK-NEXT:    unreachable
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %c1 = icmp eq i32 %x, %y
  %c2 = icmp slt i32 %x, %y
  %signed = select i1 %c2, i32 -1, i32 1
  %comparator = select i1 %c1, i32 0, i32 %signed
  br i1 %c2, label %exit, label %medium

medium:
  %c3 = icmp sgt i32 %x, %y
  br i1 %c3, label %exit, label %unreached

unreached:
  call void @use(i32 %comparator)
  unreachable

exit:
  ret void
}
