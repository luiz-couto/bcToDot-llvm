; ModuleID = '../src/FloatMM.c'
source_filename = "../src/FloatMM.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.element = type { i32, i32 }
%struct.complex = type { float, float }

@seed = dso_local global i64 0, align 8
@rma = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmb = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@rmr = dso_local global [41 x [41 x float]] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1
@value = dso_local global float 0.000000e+00, align 4
@fixed = dso_local global float 0.000000e+00, align 4
@floated = dso_local global float 0.000000e+00, align 4
@permarray = dso_local global [11 x i32] zeroinitializer, align 16
@pctr = dso_local global i32 0, align 4
@tree = dso_local global ptr null, align 8
@stack = dso_local global [4 x i32] zeroinitializer, align 16
@cellspace = dso_local global [19 x %struct.element] zeroinitializer, align 16
@freelist = dso_local global i32 0, align 4
@movesdone = dso_local global i32 0, align 4
@ima = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imb = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
@imr = dso_local global [41 x [41 x i32]] zeroinitializer, align 16
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
define dso_local void @rInitmatrix(ptr noundef %m) #0 {
entry:
  %m.addr = alloca ptr, align 8
  %temp = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store ptr %m, ptr %m.addr, align 8
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc8, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end10

for.body:                                         ; preds = %for.cond
  store i32 1, ptr %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, ptr %j, align 4
  %cmp2 = icmp sle i32 %1, 40
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %call = call i32 @Rand()
  store i32 %call, ptr %temp, align 4
  %2 = load i32, ptr %temp, align 4
  %3 = load i32, ptr %temp, align 4
  %div = sdiv i32 %3, 120
  %mul = mul nsw i32 %div, 120
  %sub = sub nsw i32 %2, %mul
  %sub4 = sub nsw i32 %sub, 60
  %conv = sitofp i32 %sub4 to float
  %div5 = fdiv float %conv, 3.000000e+00
  %4 = load ptr, ptr %m.addr, align 8
  %5 = load i32, ptr %i, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [41 x float], ptr %4, i64 %idxprom
  %6 = load i32, ptr %j, align 4
  %idxprom6 = sext i32 %6 to i64
  %arrayidx7 = getelementptr inbounds [41 x float], ptr %arrayidx, i64 0, i64 %idxprom6
  store float %div5, ptr %arrayidx7, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %7 = load i32, ptr %j, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, ptr %j, align 4
  br label %for.cond1, !llvm.loop !6

for.end:                                          ; preds = %for.cond1
  br label %for.inc8

for.inc8:                                         ; preds = %for.end
  %8 = load i32, ptr %i, align 4
  %inc9 = add nsw i32 %8, 1
  store i32 %inc9, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end10:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @rInnerproduct(ptr noundef %result, ptr noundef %a, ptr noundef %b, i32 noundef %row, i32 noundef %column) #0 {
entry:
  %result.addr = alloca ptr, align 8
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  %row.addr = alloca i32, align 4
  %column.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %result, ptr %result.addr, align 8
  store ptr %a, ptr %a.addr, align 8
  store ptr %b, ptr %b.addr, align 8
  store i32 %row, ptr %row.addr, align 4
  store i32 %column, ptr %column.addr, align 4
  %0 = load ptr, ptr %result.addr, align 8
  store float 0.000000e+00, ptr %0, align 4
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %1, 40
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load ptr, ptr %result.addr, align 8
  %3 = load float, ptr %2, align 4
  %4 = load ptr, ptr %a.addr, align 8
  %5 = load i32, ptr %row.addr, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [41 x float], ptr %4, i64 %idxprom
  %6 = load i32, ptr %i, align 4
  %idxprom1 = sext i32 %6 to i64
  %arrayidx2 = getelementptr inbounds [41 x float], ptr %arrayidx, i64 0, i64 %idxprom1
  %7 = load float, ptr %arrayidx2, align 4
  %8 = load ptr, ptr %b.addr, align 8
  %9 = load i32, ptr %i, align 4
  %idxprom3 = sext i32 %9 to i64
  %arrayidx4 = getelementptr inbounds [41 x float], ptr %8, i64 %idxprom3
  %10 = load i32, ptr %column.addr, align 4
  %idxprom5 = sext i32 %10 to i64
  %arrayidx6 = getelementptr inbounds [41 x float], ptr %arrayidx4, i64 0, i64 %idxprom5
  %11 = load float, ptr %arrayidx6, align 4
  %12 = call float @llvm.fmuladd.f32(float %7, float %11, float %3)
  %13 = load ptr, ptr %result.addr, align 8
  store float %12, ptr %13, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %14 = load i32, ptr %i, align 4
  %inc = add nsw i32 %14, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !9

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @Mm(i32 noundef %run) #0 {
entry:
  %run.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %run, ptr %run.addr, align 4
  call void @Initrand()
  call void @rInitmatrix(ptr noundef @rma)
  call void @rInitmatrix(ptr noundef @rmb)
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc6, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end8

for.body:                                         ; preds = %for.cond
  store i32 1, ptr %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, ptr %j, align 4
  %cmp2 = icmp sle i32 %1, 40
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, ptr %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds [41 x [41 x float]], ptr @rmr, i64 0, i64 %idxprom
  %3 = load i32, ptr %j, align 4
  %idxprom4 = sext i32 %3 to i64
  %arrayidx5 = getelementptr inbounds [41 x float], ptr %arrayidx, i64 0, i64 %idxprom4
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %j, align 4
  call void @rInnerproduct(ptr noundef %arrayidx5, ptr noundef @rma, ptr noundef @rmb, i32 noundef %4, i32 noundef %5)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %6 = load i32, ptr %j, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %j, align 4
  br label %for.cond1, !llvm.loop !10

for.end:                                          ; preds = %for.cond1
  br label %for.inc6

for.inc6:                                         ; preds = %for.end
  %7 = load i32, ptr %i, align 4
  %inc7 = add nsw i32 %7, 1
  store i32 %inc7, ptr %i, align 4
  br label %for.cond, !llvm.loop !11

for.end8:                                         ; preds = %for.cond
  %8 = load i32, ptr %run.addr, align 4
  %cmp9 = icmp slt i32 %8, 40
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.end8
  %9 = load i32, ptr %run.addr, align 4
  %add = add nsw i32 %9, 1
  %idxprom10 = sext i32 %add to i64
  %arrayidx11 = getelementptr inbounds [41 x [41 x float]], ptr @rmr, i64 0, i64 %idxprom10
  %10 = load i32, ptr %run.addr, align 4
  %add12 = add nsw i32 %10, 1
  %idxprom13 = sext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds [41 x float], ptr %arrayidx11, i64 0, i64 %idxprom13
  %11 = load float, ptr %arrayidx14, align 4
  %conv = fpext float %11 to double
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %conv)
  br label %if.end

if.end:                                           ; preds = %if.then, %for.end8
  ret void
}

declare i32 @printf(ptr noundef, ...) #2

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
  %cmp = icmp slt i32 %0, 5000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %i, align 4
  call void @Mm(i32 noundef %1)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %2 = load i32, ptr %i, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !12

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
