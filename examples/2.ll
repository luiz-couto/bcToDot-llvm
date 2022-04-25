; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"Max = %d\0A\00", align 1

; Function Attrs: mustprogress noinline norecurse uwtable
define dso_local noundef i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  %max = alloca i32, align 4
  %aux = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 %argc, ptr %argc.addr, align 4
  store ptr %argv, ptr %argv.addr, align 8
  store i32 1, ptr %i, align 4
  store i32 0, ptr %max, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %argc.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load ptr, ptr %argv.addr, align 8
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds ptr, ptr %2, i64 %idxprom
  %4 = load ptr, ptr %arrayidx, align 8
  %call = call i32 @atoi(ptr noundef %4) #3
  store i32 %call, ptr %aux, align 4
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  %6 = load i32, ptr %aux, align 4
  %7 = load i32, ptr %max, align 4
  %cmp1 = icmp sgt i32 %6, %7
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %8 = load i32, ptr %aux, align 4
  store i32 %8, ptr %max, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  br label %while.cond, !llvm.loop !6

while.end:                                        ; preds = %while.cond
  %9 = load i32, ptr %max, align 4
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %9)
  %10 = load i32, ptr %retval, align 4
  ret i32 %10
}

; Function Attrs: nounwind readonly willreturn
declare i32 @atoi(ptr noundef) #1

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { mustprogress noinline norecurse uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind readonly willreturn }

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
