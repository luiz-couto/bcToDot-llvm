; ModuleID = '../src/Treesort.c'
source_filename = "../src/Treesort.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.element = type { i32, i32 }
%struct.complex = type { float, float }
%struct.node = type { ptr, ptr, i32 }

@seed = dso_local global i64 0, align 8
@biggest = dso_local global i32 0, align 4
@littlest = dso_local global i32 0, align 4
@sortlist = dso_local global [5001 x i32] zeroinitializer, align 16
@tree = dso_local global ptr null, align 8
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c" Error in Tree.\0A\00", align 1
@value = dso_local global float 0.000000e+00, align 4
@fixed = dso_local global float 0.000000e+00, align 4
@floated = dso_local global float 0.000000e+00, align 4
@permarray = dso_local global [11 x i32] zeroinitializer, align 16
@pctr = dso_local global i32 0, align 4
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
define dso_local void @tInitarr() #0 {
entry:
  %i = alloca i32, align 4
  %temp = alloca i64, align 8
  call void @Initrand()
  store i32 0, ptr @biggest, align 4
  store i32 0, ptr @littlest, align 4
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %0, 5000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call = call i32 @Rand()
  %conv = sext i32 %call to i64
  store i64 %conv, ptr %temp, align 8
  %1 = load i64, ptr %temp, align 8
  %2 = load i64, ptr %temp, align 8
  %div = sdiv i64 %2, 100000
  %mul = mul nsw i64 %div, 100000
  %sub = sub nsw i64 %1, %mul
  %sub1 = sub nsw i64 %sub, 50000
  %conv2 = trunc i64 %sub1 to i32
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom
  store i32 %conv2, ptr %arrayidx, align 4
  %4 = load i32, ptr %i, align 4
  %idxprom3 = sext i32 %4 to i64
  %arrayidx4 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom3
  %5 = load i32, ptr %arrayidx4, align 4
  %6 = load i32, ptr @biggest, align 4
  %cmp5 = icmp sgt i32 %5, %6
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %7 = load i32, ptr %i, align 4
  %idxprom7 = sext i32 %7 to i64
  %arrayidx8 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom7
  %8 = load i32, ptr %arrayidx8, align 4
  store i32 %8, ptr @biggest, align 4
  br label %if.end16

if.else:                                          ; preds = %for.body
  %9 = load i32, ptr %i, align 4
  %idxprom9 = sext i32 %9 to i64
  %arrayidx10 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom9
  %10 = load i32, ptr %arrayidx10, align 4
  %11 = load i32, ptr @littlest, align 4
  %cmp11 = icmp slt i32 %10, %11
  br i1 %cmp11, label %if.then13, label %if.end

if.then13:                                        ; preds = %if.else
  %12 = load i32, ptr %i, align 4
  %idxprom14 = sext i32 %12 to i64
  %arrayidx15 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom14
  %13 = load i32, ptr %arrayidx15, align 4
  store i32 %13, ptr @littlest, align 4
  br label %if.end

if.end:                                           ; preds = %if.then13, %if.else
  br label %if.end16

if.end16:                                         ; preds = %if.end, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end16
  %14 = load i32, ptr %i, align 4
  %inc = add nsw i32 %14, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @CreateNode(ptr noundef %t, i32 noundef %n) #0 {
entry:
  %t.addr = alloca ptr, align 8
  %n.addr = alloca i32, align 4
  store ptr %t, ptr %t.addr, align 8
  store i32 %n, ptr %n.addr, align 4
  %call = call noalias ptr @malloc(i64 noundef 24) #3
  %0 = load ptr, ptr %t.addr, align 8
  store ptr %call, ptr %0, align 8
  %1 = load ptr, ptr %t.addr, align 8
  %2 = load ptr, ptr %1, align 8
  %left = getelementptr inbounds %struct.node, ptr %2, i32 0, i32 0
  store ptr null, ptr %left, align 8
  %3 = load ptr, ptr %t.addr, align 8
  %4 = load ptr, ptr %3, align 8
  %right = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 1
  store ptr null, ptr %right, align 8
  %5 = load i32, ptr %n.addr, align 4
  %6 = load ptr, ptr %t.addr, align 8
  %7 = load ptr, ptr %6, align 8
  %val = getelementptr inbounds %struct.node, ptr %7, i32 0, i32 2
  store i32 %5, ptr %val, align 8
  ret void
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @Insert(i32 noundef %n, ptr noundef %t) #0 {
entry:
  %n.addr = alloca i32, align 4
  %t.addr = alloca ptr, align 8
  store i32 %n, ptr %n.addr, align 4
  store ptr %t, ptr %t.addr, align 8
  %0 = load i32, ptr %n.addr, align 4
  %1 = load ptr, ptr %t.addr, align 8
  %val = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 2
  %2 = load i32, ptr %val, align 8
  %cmp = icmp sgt i32 %0, %2
  br i1 %cmp, label %if.then, label %if.else5

if.then:                                          ; preds = %entry
  %3 = load ptr, ptr %t.addr, align 8
  %left = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 0
  %4 = load ptr, ptr %left, align 8
  %cmp1 = icmp eq ptr %4, null
  br i1 %cmp1, label %if.then2, label %if.else

if.then2:                                         ; preds = %if.then
  %5 = load ptr, ptr %t.addr, align 8
  %left3 = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 0
  %6 = load i32, ptr %n.addr, align 4
  call void @CreateNode(ptr noundef %left3, i32 noundef %6)
  br label %if.end

if.else:                                          ; preds = %if.then
  %7 = load i32, ptr %n.addr, align 4
  %8 = load ptr, ptr %t.addr, align 8
  %left4 = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 0
  %9 = load ptr, ptr %left4, align 8
  call void @Insert(i32 noundef %7, ptr noundef %9)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  br label %if.end16

if.else5:                                         ; preds = %entry
  %10 = load i32, ptr %n.addr, align 4
  %11 = load ptr, ptr %t.addr, align 8
  %val6 = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 2
  %12 = load i32, ptr %val6, align 8
  %cmp7 = icmp slt i32 %10, %12
  br i1 %cmp7, label %if.then8, label %if.end15

if.then8:                                         ; preds = %if.else5
  %13 = load ptr, ptr %t.addr, align 8
  %right = getelementptr inbounds %struct.node, ptr %13, i32 0, i32 1
  %14 = load ptr, ptr %right, align 8
  %cmp9 = icmp eq ptr %14, null
  br i1 %cmp9, label %if.then10, label %if.else12

if.then10:                                        ; preds = %if.then8
  %15 = load ptr, ptr %t.addr, align 8
  %right11 = getelementptr inbounds %struct.node, ptr %15, i32 0, i32 1
  %16 = load i32, ptr %n.addr, align 4
  call void @CreateNode(ptr noundef %right11, i32 noundef %16)
  br label %if.end14

if.else12:                                        ; preds = %if.then8
  %17 = load i32, ptr %n.addr, align 4
  %18 = load ptr, ptr %t.addr, align 8
  %right13 = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 1
  %19 = load ptr, ptr %right13, align 8
  call void @Insert(i32 noundef %17, ptr noundef %19)
  br label %if.end14

if.end14:                                         ; preds = %if.else12, %if.then10
  br label %if.end15

if.end15:                                         ; preds = %if.end14, %if.else5
  br label %if.end16

if.end16:                                         ; preds = %if.end15, %if.end
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @Checktree(ptr noundef %p) #0 {
entry:
  %p.addr = alloca ptr, align 8
  %result = alloca i32, align 4
  store ptr %p, ptr %p.addr, align 8
  store i32 1, ptr %result, align 4
  %0 = load ptr, ptr %p.addr, align 8
  %left = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 0
  %1 = load ptr, ptr %left, align 8
  %cmp = icmp ne ptr %1, null
  br i1 %cmp, label %if.then, label %if.end7

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %p.addr, align 8
  %left1 = getelementptr inbounds %struct.node, ptr %2, i32 0, i32 0
  %3 = load ptr, ptr %left1, align 8
  %val = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 2
  %4 = load i32, ptr %val, align 8
  %5 = load ptr, ptr %p.addr, align 8
  %val2 = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 2
  %6 = load i32, ptr %val2, align 8
  %cmp3 = icmp sle i32 %4, %6
  br i1 %cmp3, label %if.then4, label %if.else

if.then4:                                         ; preds = %if.then
  store i32 0, ptr %result, align 4
  br label %if.end

if.else:                                          ; preds = %if.then
  %7 = load ptr, ptr %p.addr, align 8
  %left5 = getelementptr inbounds %struct.node, ptr %7, i32 0, i32 0
  %8 = load ptr, ptr %left5, align 8
  %call = call i32 @Checktree(ptr noundef %8)
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %if.else
  %9 = load i32, ptr %result, align 4
  %tobool6 = icmp ne i32 %9, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %if.else
  %10 = phi i1 [ false, %if.else ], [ %tobool6, %land.rhs ]
  %land.ext = zext i1 %10 to i32
  store i32 %land.ext, ptr %result, align 4
  br label %if.end

if.end:                                           ; preds = %land.end, %if.then4
  br label %if.end7

if.end7:                                          ; preds = %if.end, %entry
  %11 = load ptr, ptr %p.addr, align 8
  %right = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 1
  %12 = load ptr, ptr %right, align 8
  %cmp8 = icmp ne ptr %12, null
  br i1 %cmp8, label %if.then9, label %if.end24

if.then9:                                         ; preds = %if.end7
  %13 = load ptr, ptr %p.addr, align 8
  %right10 = getelementptr inbounds %struct.node, ptr %13, i32 0, i32 1
  %14 = load ptr, ptr %right10, align 8
  %val11 = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 2
  %15 = load i32, ptr %val11, align 8
  %16 = load ptr, ptr %p.addr, align 8
  %val12 = getelementptr inbounds %struct.node, ptr %16, i32 0, i32 2
  %17 = load i32, ptr %val12, align 8
  %cmp13 = icmp sge i32 %15, %17
  br i1 %cmp13, label %if.then14, label %if.else15

if.then14:                                        ; preds = %if.then9
  store i32 0, ptr %result, align 4
  br label %if.end23

if.else15:                                        ; preds = %if.then9
  %18 = load ptr, ptr %p.addr, align 8
  %right16 = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 1
  %19 = load ptr, ptr %right16, align 8
  %call17 = call i32 @Checktree(ptr noundef %19)
  %tobool18 = icmp ne i32 %call17, 0
  br i1 %tobool18, label %land.rhs19, label %land.end21

land.rhs19:                                       ; preds = %if.else15
  %20 = load i32, ptr %result, align 4
  %tobool20 = icmp ne i32 %20, 0
  br label %land.end21

land.end21:                                       ; preds = %land.rhs19, %if.else15
  %21 = phi i1 [ false, %if.else15 ], [ %tobool20, %land.rhs19 ]
  %land.ext22 = zext i1 %21 to i32
  store i32 %land.ext22, ptr %result, align 4
  br label %if.end23

if.end23:                                         ; preds = %land.end21, %if.then14
  br label %if.end24

if.end24:                                         ; preds = %if.end23, %if.end7
  %22 = load i32, ptr %result, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @Trees(i32 noundef %run) #0 {
entry:
  %run.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %run, ptr %run.addr, align 4
  call void @tInitarr()
  %call = call noalias ptr @malloc(i64 noundef 24) #3
  store ptr %call, ptr @tree, align 8
  %0 = load ptr, ptr @tree, align 8
  %left = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 0
  store ptr null, ptr %left, align 8
  %1 = load ptr, ptr @tree, align 8
  %right = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 1
  store ptr null, ptr %right, align 8
  %2 = load i32, ptr getelementptr inbounds ([5001 x i32], ptr @sortlist, i64 0, i64 1), align 4
  %3 = load ptr, ptr @tree, align 8
  %val = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 2
  store i32 %2, ptr %val, align 8
  store i32 2, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %cmp = icmp sle i32 %4, 5000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %5 = load i32, ptr %i, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom
  %6 = load i32, ptr %arrayidx, align 4
  %7 = load ptr, ptr @tree, align 8
  call void @Insert(i32 noundef %6, ptr noundef %7)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32, ptr %i, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  %9 = load i32, ptr %run.addr, align 4
  %add = add nsw i32 2, %9
  %idxprom1 = sext i32 %add to i64
  %arrayidx2 = getelementptr inbounds [5001 x i32], ptr @sortlist, i64 0, i64 %idxprom1
  %10 = load i32, ptr %arrayidx2, align 4
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %10)
  %11 = load ptr, ptr @tree, align 8
  %call4 = call i32 @Checktree(ptr noundef %11)
  %tobool = icmp ne i32 %call4, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %for.end
  %call5 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %if.end

if.end:                                           ; preds = %if.then, %for.end
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
  %cmp = icmp slt i32 %0, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %i, align 4
  call void @Trees(i32 noundef %1)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %2 = load i32, ptr %i, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !9

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind allocsize(0) }

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
