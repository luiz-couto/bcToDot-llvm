; ModuleID = '../src/Perm.c'
source_filename = "../src/Perm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.element = type { i32, i32 }
%struct.complex = type { float, float }

@seed = dso_local global i64 0, align 8
@permarray = dso_local global [11 x i32] zeroinitializer, align 16
@pctr = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [17 x i8] c" Error in Perm.\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@value = dso_local global float 0.000000e+00, align 4
@fixed = dso_local global float 0.000000e+00, align 4
@floated = dso_local global float 0.000000e+00, align 4
@tree = dso_local global ptr null, align 8
@stack = dso_local global [4 x i32] zeroinitializer, align 16
@cellspace = dso_local global [19 x %struct.element] zeroinitializer, align 16
@freelist = dso_local global i32 0, align 4
@movesdone = dso_local global i32 0, align 4
@ima = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imb = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imr = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@rma = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmb = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmr = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@piececount = dso_local global [4 x i32] zeroinitializer, align 16
@class = dso_local global [13 x i32] zeroinitializer, align 16
@piecemax = dso_local global [13 x i32] zeroinitializer, align 16
@puzzl = dso_local global [512 x i32] zeroinitializer, align 16
@p = dso_local global [13 x [512 x i32]] zeroinitializer, align 16
@n = dso_local global i32 0, align 4
@kount = dso_local global i32 0, align 4
@sortlist = dso_local global [5001 x i32] zeroinitializer, align 16
@biggest = dso_local global i32 0, align 4
@littlest = dso_local global i32 0, align 4
@top = dso_local global i32 0, align 4
@z = dso_local global [257 x %struct.complex] zeroinitializer, align 16
@w = dso_local global [257 x %struct.complex] zeroinitializer, align 16
@e = dso_local global [130 x %struct.complex] zeroinitializer, align 16
@zr = dso_local global float 0.000000e+00, align 4
@zi = dso_local global float 0.000000e+00, align 4

; Function Attrs: noinline nounwind uwtable
define dso_local void @Initrand() #0 {
entry:
  store i64 74755, ptr @seed, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @Rand() #0 {
entry:
  %0 = load i64, ptr @seed, align 8
  %mul = mul nsw i64 %0, 1309
  %add = add nsw i64 %mul, 13849
  %and = and i64 %add, 65535
  store i64 %and, ptr @seed, align 8
  %1 = load i64, ptr @seed, align 8
  %conv = trunc i64 %1 to i32
  ret i32 %conv
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @Swap(ptr noundef %a, ptr noundef %b) #0 {
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  %t = alloca i32, align 4
  store ptr %a, ptr %a.addr, align 8
  store ptr %b, ptr %b.addr, align 8
  %0 = load ptr, ptr %a.addr, align 8
  %1 = load i32, ptr %0, align 4
  store i32 %1, ptr %t, align 4
  %2 = load ptr, ptr %b.addr, align 8
  %3 = load i32, ptr %2, align 4
  %4 = load ptr, ptr %a.addr, align 8
  store i32 %3, ptr %4, align 4
  %5 = load i32, ptr %t, align 4
  %6 = load ptr, ptr %b.addr, align 8
  store i32 %5, ptr %6, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @Initialize() #0 {
entry:
  %i = alloca i32, align 4
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %0, 7
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %i, align 4
  %sub = sub nsw i32 %1, 1
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds [11 x i32], ptr @permarray, i64 0, i64 %idxprom
  store i32 %sub, ptr %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, ptr %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @Permute(i32 noundef %n) #0 {
entry:
  %n.addr = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %n, ptr %n.addr, align 4
  %0 = load i32, ptr @pctr, align 4
  %add = add i32 %0, 1
  store i32 %add, ptr @pctr, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp ne i32 %1, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load i32, ptr %n.addr, align 4
  %sub = sub nsw i32 %2, 1
  call void @Permute(i32 noundef %sub)
  %3 = load i32, ptr %n.addr, align 4
  %sub1 = sub nsw i32 %3, 1
  store i32 %sub1, ptr %k, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.then
  %4 = load i32, ptr %k, align 4
  %cmp2 = icmp sge i32 %4, 1
  br i1 %cmp2, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %5 = load i32, ptr %n.addr, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [11 x i32], ptr @permarray, i64 0, i64 %idxprom
  %6 = load i32, ptr %k, align 4
  %idxprom3 = sext i32 %6 to i64
  %arrayidx4 = getelementptr inbounds [11 x i32], ptr @permarray, i64 0, i64 %idxprom3
  call void @Swap(ptr noundef %arrayidx, ptr noundef %arrayidx4)
  %7 = load i32, ptr %n.addr, align 4
  %sub5 = sub nsw i32 %7, 1
  call void @Permute(i32 noundef %sub5)
  %8 = load i32, ptr %n.addr, align 4
  %idxprom6 = sext i32 %8 to i64
  %arrayidx7 = getelementptr inbounds [11 x i32], ptr @permarray, i64 0, i64 %idxprom6
  %9 = load i32, ptr %k, align 4
  %idxprom8 = sext i32 %9 to i64
  %arrayidx9 = getelementptr inbounds [11 x i32], ptr @permarray, i64 0, i64 %idxprom8
  call void @Swap(ptr noundef %arrayidx7, ptr noundef %arrayidx9)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32, ptr %k, align 4
  %dec = add nsw i32 %10, -1
  store i32 %dec, ptr %k, align 4
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  br label %if.end

if.end:                                           ; preds = %for.end, %entry
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @Perm() #0 {
entry:
  %i = alloca i32, align 4
  store i32 0, ptr @pctr, align 4
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %0, 5
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Initialize()
  call void @Permute(i32 noundef 7)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %1 = load i32, ptr %i, align 4
  %inc = add nsw i32 %1, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !9

for.end:                                          ; preds = %for.cond
  %2 = load i32, ptr @pctr, align 4
  %cmp1 = icmp ne i32 %2, 43300
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %for.end
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str)
  br label %if.end

if.end:                                           ; preds = %if.then, %for.end
  %3 = load i32, ptr @pctr, align 4
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call void @Perm()
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %1 = load i32, ptr %i, align 4
  %inc = add nsw i32 %1, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !10

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 15.0.0 (git@github.com:llvm/llvm-project.git 3f0f20366622ee5fd35a1d65d7db5226f5e5751f)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
