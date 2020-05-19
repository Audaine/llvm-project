; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX2 --check-prefix=AVX2NOBW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefix=AVX2 --check-prefix=AVX512BW

;
; sdiv by 7
;

define <4 x i64> @test_div7_4i64(<4 x i64> %a) nounwind {
; AVX1-LABEL: test_div7_4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpextrq $1, %xmm1, %rax
; AVX1-NEXT:    movabsq $5270498306774157605, %rcx # imm = 0x4924924924924925
; AVX1-NEXT:    imulq %rcx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm2
; AVX1-NEXT:    vmovq %xmm1, %rax
; AVX1-NEXT:    imulq %rcx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; AVX1-NEXT:    vpextrq $1, %xmm0, %rax
; AVX1-NEXT:    imulq %rcx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm2
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    imulq %rcx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_div7_4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; AVX2-NEXT:    movabsq $5270498306774157605, %rcx # imm = 0x4924924924924925
; AVX2-NEXT:    imulq %rcx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm2
; AVX2-NEXT:    vmovq %xmm1, %rax
; AVX2-NEXT:    imulq %rcx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm1
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; AVX2-NEXT:    vpextrq $1, %xmm0, %rax
; AVX2-NEXT:    imulq %rcx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm2
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    imulq %rcx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm0
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %res = sdiv <4 x i64> %a, <i64 7, i64 7, i64 7, i64 7>
  ret <4 x i64> %res
}

define <8 x i32> @test_div7_8i32(<8 x i32> %a) nounwind {
; AVX1-LABEL: test_div7_8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm3 = [2454267027,2454267027,2454267027,2454267027]
; AVX1-NEXT:    vpmuldq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpmuldq %xmm3, %xmm1, %xmm4
; AVX1-NEXT:    vpshufd {{.*#+}} xmm4 = xmm4[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm2 = xmm4[0,1],xmm2[2,3],xmm4[4,5],xmm2[6,7]
; AVX1-NEXT:    vpaddd %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vpsrld $31, %xmm1, %xmm2
; AVX1-NEXT:    vpsrad $2, %xmm1, %xmm1
; AVX1-NEXT:    vpaddd %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpmuldq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpmuldq %xmm3, %xmm0, %xmm3
; AVX1-NEXT:    vpshufd {{.*#+}} xmm3 = xmm3[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm2 = xmm3[0,1],xmm2[2,3],xmm3[4,5],xmm2[6,7]
; AVX1-NEXT:    vpaddd %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vpsrld $31, %xmm0, %xmm2
; AVX1-NEXT:    vpsrad $2, %xmm0, %xmm0
; AVX1-NEXT:    vpaddd %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_div7_8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpshufd {{.*#+}} ymm1 = ymm0[1,1,3,3,5,5,7,7]
; AVX2-NEXT:    vpbroadcastd {{.*#+}} ymm2 = [2454267027,2454267027,2454267027,2454267027,2454267027,2454267027,2454267027,2454267027]
; AVX2-NEXT:    vpmuldq %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vpmuldq %ymm2, %ymm0, %ymm2
; AVX2-NEXT:    vpshufd {{.*#+}} ymm2 = ymm2[1,1,3,3,5,5,7,7]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0],ymm1[1],ymm2[2],ymm1[3],ymm2[4],ymm1[5],ymm2[6],ymm1[7]
; AVX2-NEXT:    vpaddd %ymm0, %ymm1, %ymm0
; AVX2-NEXT:    vpsrld $31, %ymm0, %ymm1
; AVX2-NEXT:    vpsrad $2, %ymm0, %ymm0
; AVX2-NEXT:    vpaddd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %res = sdiv <8 x i32> %a, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  ret <8 x i32> %res
}

define <16 x i16> @test_div7_16i16(<16 x i16> %a) nounwind {
; AVX1-LABEL: test_div7_16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = [18725,18725,18725,18725,18725,18725,18725,18725]
; AVX1-NEXT:    vpmulhw %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpsrlw $15, %xmm1, %xmm3
; AVX1-NEXT:    vpsraw $1, %xmm1, %xmm1
; AVX1-NEXT:    vpaddw %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vpmulhw %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpsrlw $15, %xmm0, %xmm2
; AVX1-NEXT:    vpsraw $1, %xmm0, %xmm0
; AVX1-NEXT:    vpaddw %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_div7_16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmulhw {{.*}}(%rip), %ymm0, %ymm0
; AVX2-NEXT:    vpsrlw $15, %ymm0, %ymm1
; AVX2-NEXT:    vpsraw $1, %ymm0, %ymm0
; AVX2-NEXT:    vpaddw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %res = sdiv <16 x i16> %a, <i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7>
  ret <16 x i16> %res
}

define <32 x i8> @test_div7_32i8(<32 x i8> %a) nounwind {
; AVX1-LABEL: test_div7_32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpmovsxbw %xmm1, %xmm2
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm3 = [65427,65427,65427,65427,65427,65427,65427,65427]
; AVX1-NEXT:    vpmullw %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $8, %xmm2, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm4 = xmm1[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm4, %xmm4
; AVX1-NEXT:    vpmullw %xmm3, %xmm4, %xmm4
; AVX1-NEXT:    vpsrlw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpackuswb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vpsrlw $7, %xmm1, %xmm2
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm4 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX1-NEXT:    vpand %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $2, %xmm1, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm5 = [63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63]
; AVX1-NEXT:    vpand %xmm5, %xmm1, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm6 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
; AVX1-NEXT:    vpxor %xmm6, %xmm1, %xmm1
; AVX1-NEXT:    vpaddb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpsubb %xmm6, %xmm1, %xmm1
; AVX1-NEXT:    vpmovsxbw %xmm0, %xmm2
; AVX1-NEXT:    vpmullw %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $8, %xmm2, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm7 = xmm0[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm7, %xmm7
; AVX1-NEXT:    vpmullw %xmm3, %xmm7, %xmm3
; AVX1-NEXT:    vpsrlw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpackuswb %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vpsrlw $7, %xmm0, %xmm2
; AVX1-NEXT:    vpand %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $2, %xmm0, %xmm0
; AVX1-NEXT:    vpand %xmm5, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm6, %xmm0, %xmm0
; AVX1-NEXT:    vpaddb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpsubb %xmm6, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2NOBW-LABEL: test_div7_32i8:
; AVX2NOBW:       # %bb.0:
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm1 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vmovdqa {{.*#+}} ymm2 = [65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427]
; AVX2NOBW-NEXT:    vpmullw %ymm2, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm3 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpmullw %ymm2, %ymm3, %ymm2
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpackuswb %ymm1, %ymm2, %ymm1
; AVX2NOBW-NEXT:    vpaddb %ymm0, %ymm1, %ymm0
; AVX2NOBW-NEXT:    vpsrlw $2, %ymm0, %ymm1
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm1, %ymm1
; AVX2NOBW-NEXT:    vmovdqa {{.*#+}} ymm2 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
; AVX2NOBW-NEXT:    vpxor %ymm2, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsrlw $7, %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpaddb %ymm0, %ymm1, %ymm0
; AVX2NOBW-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX2NOBW-NEXT:    retq
;
; AVX512BW-LABEL: test_div7_32i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovsxbw %ymm0, %zmm1
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm1, %zmm1
; AVX512BW-NEXT:    vpsrlw $8, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovwb %zmm1, %ymm1
; AVX512BW-NEXT:    vpaddb %ymm0, %ymm1, %ymm0
; AVX512BW-NEXT:    vpsrlw $2, %ymm0, %ymm1
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm1, %ymm1
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm2 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
; AVX512BW-NEXT:    vpxor %ymm2, %ymm1, %ymm1
; AVX512BW-NEXT:    vpsrlw $7, %ymm0, %ymm0
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm0, %ymm0
; AVX512BW-NEXT:    vpaddb %ymm0, %ymm1, %ymm0
; AVX512BW-NEXT:    vpsubb %ymm2, %ymm0, %ymm0
; AVX512BW-NEXT:    retq
  %res = sdiv <32 x i8> %a, <i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7>
  ret <32 x i8> %res
}

;
; sdiv by non-splat constant
;

define <32 x i8> @test_divconstant_32i8(<32 x i8> %a) nounwind {
; AVX1-LABEL: test_divconstant_32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm1 = xmm2[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm1, %xmm3
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm1 = [255,255,255,255,255,255,255,255]
; AVX1-NEXT:    vpand %xmm1, %xmm3, %xmm3
; AVX1-NEXT:    vpmovzxbw {{.*#+}} xmm4 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpand %xmm1, %xmm4, %xmm4
; AVX1-NEXT:    vpackuswb %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpmovsxbw %xmm2, %xmm4
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpsrlw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm2[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm2, %xmm2
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $8, %xmm2, %xmm2
; AVX1-NEXT:    vpackuswb %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpaddb %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm3 = xmm2[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpsraw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm3, %xmm3
; AVX1-NEXT:    vpsrlw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpunpcklbw {{.*#+}} xmm4 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; AVX1-NEXT:    vpsraw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpsrlw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpackuswb %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpsrlw $7, %xmm2, %xmm2
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm4 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX1-NEXT:    vpand %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm3 = xmm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm3, %xmm3
; AVX1-NEXT:    vpand %xmm1, %xmm3, %xmm3
; AVX1-NEXT:    vpmovzxbw {{.*#+}} xmm5 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpand %xmm1, %xmm5, %xmm1
; AVX1-NEXT:    vpackuswb %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vpmovsxbw %xmm0, %xmm3
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm3, %xmm3
; AVX1-NEXT:    vpsrlw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm0, %xmm0
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpsrlw $8, %xmm0, %xmm0
; AVX1-NEXT:    vpackuswb %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vpaddb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm1 = xmm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpsraw $8, %xmm1, %xmm1
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vpsrlw $8, %xmm1, %xmm1
; AVX1-NEXT:    vpunpcklbw {{.*#+}} xmm3 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; AVX1-NEXT:    vpsraw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm3, %xmm3
; AVX1-NEXT:    vpsrlw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpackuswb %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpsrlw $7, %xmm0, %xmm0
; AVX1-NEXT:    vpand %xmm4, %xmm0, %xmm0
; AVX1-NEXT:    vpaddb %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2NOBW-LABEL: test_divconstant_32i8:
; AVX2NOBW:       # %bb.0:
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm1 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm1, %ymm1
; AVX2NOBW-NEXT:    vmovdqa {{.*#+}} ymm2 = [255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255]
; AVX2NOBW-NEXT:    vpand %ymm2, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm3 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpand %ymm2, %ymm3, %ymm2
; AVX2NOBW-NEXT:    vpackuswb %ymm1, %ymm2, %ymm1
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm2 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm0 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpackuswb %ymm2, %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpaddb %ymm1, %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm1 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm2 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpackuswb %ymm1, %ymm2, %ymm1
; AVX2NOBW-NEXT:    vpsrlw $7, %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm0, %ymm0
; AVX2NOBW-NEXT:    vpaddb %ymm0, %ymm1, %ymm0
; AVX2NOBW-NEXT:    retq
;
; AVX512BW-LABEL: test_divconstant_32i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovzxbw {{.*#+}} zmm1 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero,ymm0[16],zero,ymm0[17],zero,ymm0[18],zero,ymm0[19],zero,ymm0[20],zero,ymm0[21],zero,ymm0[22],zero,ymm0[23],zero,ymm0[24],zero,ymm0[25],zero,ymm0[26],zero,ymm0[27],zero,ymm0[28],zero,ymm0[29],zero,ymm0[30],zero,ymm0[31],zero
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovwb %zmm1, %ymm1
; AVX512BW-NEXT:    vpmovsxbw %ymm0, %zmm0
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    vpsrlw $8, %zmm0, %zmm0
; AVX512BW-NEXT:    vpmovwb %zmm0, %ymm0
; AVX512BW-NEXT:    vpaddb %ymm1, %ymm0, %ymm0
; AVX512BW-NEXT:    vpsrlw $7, %ymm0, %ymm1
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm1, %ymm1
; AVX512BW-NEXT:    vpmovsxbw %ymm0, %zmm0
; AVX512BW-NEXT:    vpsravw {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    vpmovwb %zmm0, %ymm0
; AVX512BW-NEXT:    vpaddb %ymm1, %ymm0, %ymm0
; AVX512BW-NEXT:    retq
  %res = sdiv <32 x i8> %a, <i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15, i8 16, i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 22, i8 21, i8 20, i8 19, i8 18, i8 17, i8 16, i8 15, i8 14, i8 13, i8 12, i8 11, i8 10, i8 9, i8 8, i8 7>
  ret <32 x i8> %res
}

;
; srem by 7
;

define <4 x i64> @test_rem7_4i64(<4 x i64> %a) nounwind {
; AVX1-LABEL: test_rem7_4i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX1-NEXT:    movabsq $5270498306774157605, %rsi # imm = 0x4924924924924925
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rsi
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    leaq (,%rdx,8), %rax
; AVX1-NEXT:    subq %rax, %rdx
; AVX1-NEXT:    addq %rcx, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm2
; AVX1-NEXT:    vmovq %xmm1, %rcx
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rsi
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    leaq (,%rdx,8), %rax
; AVX1-NEXT:    subq %rax, %rdx
; AVX1-NEXT:    addq %rcx, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; AVX1-NEXT:    vpextrq $1, %xmm0, %rcx
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rsi
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    leaq (,%rdx,8), %rax
; AVX1-NEXT:    subq %rax, %rdx
; AVX1-NEXT:    addq %rcx, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm2
; AVX1-NEXT:    vmovq %xmm0, %rcx
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rsi
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    leaq (,%rdx,8), %rax
; AVX1-NEXT:    subq %rax, %rdx
; AVX1-NEXT:    addq %rcx, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_rem7_4i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX2-NEXT:    movabsq $5270498306774157605, %rsi # imm = 0x4924924924924925
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rsi
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    leaq (,%rdx,8), %rax
; AVX2-NEXT:    subq %rax, %rdx
; AVX2-NEXT:    addq %rcx, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm2
; AVX2-NEXT:    vmovq %xmm1, %rcx
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rsi
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    leaq (,%rdx,8), %rax
; AVX2-NEXT:    subq %rax, %rdx
; AVX2-NEXT:    addq %rcx, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm1
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; AVX2-NEXT:    vpextrq $1, %xmm0, %rcx
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rsi
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    leaq (,%rdx,8), %rax
; AVX2-NEXT:    subq %rax, %rdx
; AVX2-NEXT:    addq %rcx, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm2
; AVX2-NEXT:    vmovq %xmm0, %rcx
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rsi
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    leaq (,%rdx,8), %rax
; AVX2-NEXT:    subq %rax, %rdx
; AVX2-NEXT:    addq %rcx, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm0
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %res = srem <4 x i64> %a, <i64 7, i64 7, i64 7, i64 7>
  ret <4 x i64> %res
}

define <8 x i32> @test_rem7_8i32(<8 x i32> %a) nounwind {
; AVX1-LABEL: test_rem7_8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm3 = [2454267027,2454267027,2454267027,2454267027]
; AVX1-NEXT:    vpmuldq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpmuldq %xmm3, %xmm1, %xmm4
; AVX1-NEXT:    vpshufd {{.*#+}} xmm4 = xmm4[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm2 = xmm4[0,1],xmm2[2,3],xmm4[4,5],xmm2[6,7]
; AVX1-NEXT:    vpaddd %xmm1, %xmm2, %xmm2
; AVX1-NEXT:    vpsrld $31, %xmm2, %xmm4
; AVX1-NEXT:    vpsrad $2, %xmm2, %xmm2
; AVX1-NEXT:    vpaddd %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpslld $3, %xmm2, %xmm4
; AVX1-NEXT:    vpsubd %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpaddd %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpmuldq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpmuldq %xmm3, %xmm0, %xmm3
; AVX1-NEXT:    vpshufd {{.*#+}} xmm3 = xmm3[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm2 = xmm3[0,1],xmm2[2,3],xmm3[4,5],xmm2[6,7]
; AVX1-NEXT:    vpaddd %xmm0, %xmm2, %xmm2
; AVX1-NEXT:    vpsrld $31, %xmm2, %xmm3
; AVX1-NEXT:    vpsrad $2, %xmm2, %xmm2
; AVX1-NEXT:    vpaddd %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpslld $3, %xmm2, %xmm3
; AVX1-NEXT:    vpsubd %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpaddd %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_rem7_8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpshufd {{.*#+}} ymm1 = ymm0[1,1,3,3,5,5,7,7]
; AVX2-NEXT:    vpbroadcastd {{.*#+}} ymm2 = [2454267027,2454267027,2454267027,2454267027,2454267027,2454267027,2454267027,2454267027]
; AVX2-NEXT:    vpmuldq %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vpmuldq %ymm2, %ymm0, %ymm2
; AVX2-NEXT:    vpshufd {{.*#+}} ymm2 = ymm2[1,1,3,3,5,5,7,7]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0],ymm1[1],ymm2[2],ymm1[3],ymm2[4],ymm1[5],ymm2[6],ymm1[7]
; AVX2-NEXT:    vpaddd %ymm0, %ymm1, %ymm1
; AVX2-NEXT:    vpsrld $31, %ymm1, %ymm2
; AVX2-NEXT:    vpsrad $2, %ymm1, %ymm1
; AVX2-NEXT:    vpaddd %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vpbroadcastd {{.*#+}} ymm2 = [7,7,7,7,7,7,7,7]
; AVX2-NEXT:    vpmulld %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vpsubd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %res = srem <8 x i32> %a, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  ret <8 x i32> %res
}

define <16 x i16> @test_rem7_16i16(<16 x i16> %a) nounwind {
; AVX1-LABEL: test_rem7_16i16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = [18725,18725,18725,18725,18725,18725,18725,18725]
; AVX1-NEXT:    vpmulhw %xmm2, %xmm1, %xmm3
; AVX1-NEXT:    vpsrlw $15, %xmm3, %xmm4
; AVX1-NEXT:    vpsraw $1, %xmm3, %xmm3
; AVX1-NEXT:    vpaddw %xmm4, %xmm3, %xmm3
; AVX1-NEXT:    vpsllw $3, %xmm3, %xmm4
; AVX1-NEXT:    vpsubw %xmm4, %xmm3, %xmm3
; AVX1-NEXT:    vpaddw %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vpmulhw %xmm2, %xmm0, %xmm2
; AVX1-NEXT:    vpsrlw $15, %xmm2, %xmm3
; AVX1-NEXT:    vpsraw $1, %xmm2, %xmm2
; AVX1-NEXT:    vpaddw %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpsllw $3, %xmm2, %xmm3
; AVX1-NEXT:    vpsubw %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpaddw %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_rem7_16i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmulhw {{.*}}(%rip), %ymm0, %ymm1
; AVX2-NEXT:    vpsrlw $15, %ymm1, %ymm2
; AVX2-NEXT:    vpsraw $1, %ymm1, %ymm1
; AVX2-NEXT:    vpaddw %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vpmullw {{.*}}(%rip), %ymm1, %ymm1
; AVX2-NEXT:    vpsubw %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %res = srem <16 x i16> %a, <i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7>
  ret <16 x i16> %res
}

define <32 x i8> @test_rem7_32i8(<32 x i8> %a) nounwind {
; AVX1-LABEL: test_rem7_32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpmovsxbw %xmm1, %xmm2
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm3 = [65427,65427,65427,65427,65427,65427,65427,65427]
; AVX1-NEXT:    vpmullw %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $8, %xmm2, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm4 = xmm1[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm4, %xmm4
; AVX1-NEXT:    vpmullw %xmm3, %xmm4, %xmm4
; AVX1-NEXT:    vpsrlw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpackuswb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm1, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $7, %xmm2, %xmm4
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm8 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX1-NEXT:    vpand %xmm4, %xmm8, %xmm4
; AVX1-NEXT:    vpsrlw $2, %xmm2, %xmm2
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm6 = [63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63]
; AVX1-NEXT:    vpand %xmm6, %xmm2, %xmm2
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm7 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
; AVX1-NEXT:    vpxor %xmm7, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpsubb %xmm7, %xmm2, %xmm2
; AVX1-NEXT:    vpsllw $3, %xmm2, %xmm4
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm5 = [248,248,248,248,248,248,248,248,248,248,248,248,248,248,248,248]
; AVX1-NEXT:    vpand %xmm5, %xmm4, %xmm4
; AVX1-NEXT:    vpsubb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpmovsxbw %xmm0, %xmm2
; AVX1-NEXT:    vpmullw %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $8, %xmm2, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm4 = xmm0[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm4, %xmm4
; AVX1-NEXT:    vpmullw %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpsrlw $8, %xmm3, %xmm3
; AVX1-NEXT:    vpackuswb %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm0, %xmm2, %xmm2
; AVX1-NEXT:    vpsrlw $7, %xmm2, %xmm3
; AVX1-NEXT:    vpand %xmm3, %xmm8, %xmm3
; AVX1-NEXT:    vpsrlw $2, %xmm2, %xmm2
; AVX1-NEXT:    vpand %xmm6, %xmm2, %xmm2
; AVX1-NEXT:    vpxor %xmm7, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpsubb %xmm7, %xmm2, %xmm2
; AVX1-NEXT:    vpsllw $3, %xmm2, %xmm3
; AVX1-NEXT:    vpand %xmm5, %xmm3, %xmm3
; AVX1-NEXT:    vpsubb %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpaddb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2NOBW-LABEL: test_rem7_32i8:
; AVX2NOBW:       # %bb.0:
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm1 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vmovdqa {{.*#+}} ymm2 = [65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427,65427]
; AVX2NOBW-NEXT:    vpmullw %ymm2, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm3 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpmullw %ymm2, %ymm3, %ymm2
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpackuswb %ymm1, %ymm2, %ymm1
; AVX2NOBW-NEXT:    vpaddb %ymm0, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsrlw $2, %ymm1, %ymm2
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm2, %ymm2
; AVX2NOBW-NEXT:    vmovdqa {{.*#+}} ymm3 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
; AVX2NOBW-NEXT:    vpxor %ymm3, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpsrlw $7, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpaddb %ymm1, %ymm2, %ymm1
; AVX2NOBW-NEXT:    vpsubb %ymm3, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsllw $3, %ymm1, %ymm2
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpsubb %ymm2, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpaddb %ymm1, %ymm0, %ymm0
; AVX2NOBW-NEXT:    retq
;
; AVX512BW-LABEL: test_rem7_32i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovsxbw %ymm0, %zmm1
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm1, %zmm1
; AVX512BW-NEXT:    vpsrlw $8, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovwb %zmm1, %ymm1
; AVX512BW-NEXT:    vpaddb %ymm0, %ymm1, %ymm1
; AVX512BW-NEXT:    vpsrlw $2, %ymm1, %ymm2
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm2, %ymm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm3 = [32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32]
; AVX512BW-NEXT:    vpxor %ymm3, %ymm2, %ymm2
; AVX512BW-NEXT:    vpsrlw $7, %ymm1, %ymm1
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm1, %ymm1
; AVX512BW-NEXT:    vpaddb %ymm1, %ymm2, %ymm1
; AVX512BW-NEXT:    vpsubb %ymm3, %ymm1, %ymm1
; AVX512BW-NEXT:    vpsllw $3, %ymm1, %ymm2
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm2, %ymm2
; AVX512BW-NEXT:    vpsubb %ymm2, %ymm1, %ymm1
; AVX512BW-NEXT:    vpaddb %ymm1, %ymm0, %ymm0
; AVX512BW-NEXT:    retq
  %res = srem <32 x i8> %a, <i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7,i8 7, i8 7, i8 7, i8 7>
  ret <32 x i8> %res
}

;
; srem by non-splat constant
;

define <32 x i8> @test_remconstant_32i8(<32 x i8> %a) nounwind {
; AVX1-LABEL: test_remconstant_32i8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm1 = xmm2[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm1, %xmm3
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm1 = [255,255,255,255,255,255,255,255]
; AVX1-NEXT:    vpand %xmm1, %xmm3, %xmm3
; AVX1-NEXT:    vpmovzxbw {{.*#+}} xmm4 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpand %xmm1, %xmm4, %xmm4
; AVX1-NEXT:    vpackuswb %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpmovsxbw %xmm2, %xmm4
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpsrlw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpshufd {{.*#+}} xmm5 = xmm2[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm5, %xmm5
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpsrlw $8, %xmm5, %xmm5
; AVX1-NEXT:    vpackuswb %xmm5, %xmm4, %xmm4
; AVX1-NEXT:    vpaddb %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm4 = xmm3[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpsraw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpsrlw $8, %xmm4, %xmm4
; AVX1-NEXT:    vpunpcklbw {{.*#+}} xmm5 = xmm3[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; AVX1-NEXT:    vpsraw $8, %xmm5, %xmm5
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpsrlw $8, %xmm5, %xmm5
; AVX1-NEXT:    vpackuswb %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpsrlw $7, %xmm3, %xmm5
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm3 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX1-NEXT:    vpand %xmm3, %xmm5, %xmm5
; AVX1-NEXT:    vpaddb %xmm5, %xmm4, %xmm4
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm5 = xmm4[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpand %xmm1, %xmm5, %xmm5
; AVX1-NEXT:    vpmovzxbw {{.*#+}} xmm4 = xmm4[0],zero,xmm4[1],zero,xmm4[2],zero,xmm4[3],zero,xmm4[4],zero,xmm4[5],zero,xmm4[6],zero,xmm4[7],zero
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpand %xmm1, %xmm4, %xmm4
; AVX1-NEXT:    vpackuswb %xmm5, %xmm4, %xmm4
; AVX1-NEXT:    vpsubb %xmm4, %xmm2, %xmm2
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm4 = xmm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpand %xmm1, %xmm4, %xmm4
; AVX1-NEXT:    vpmovzxbw {{.*#+}} xmm5 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpand %xmm1, %xmm5, %xmm5
; AVX1-NEXT:    vpackuswb %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpmovsxbw %xmm0, %xmm5
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpsrlw $8, %xmm5, %xmm5
; AVX1-NEXT:    vpshufd {{.*#+}} xmm6 = xmm0[2,3,0,1]
; AVX1-NEXT:    vpmovsxbw %xmm6, %xmm6
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm6, %xmm6
; AVX1-NEXT:    vpsrlw $8, %xmm6, %xmm6
; AVX1-NEXT:    vpackuswb %xmm6, %xmm5, %xmm5
; AVX1-NEXT:    vpaddb %xmm4, %xmm5, %xmm4
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm5 = xmm4[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpsraw $8, %xmm5, %xmm5
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm5, %xmm5
; AVX1-NEXT:    vpsrlw $8, %xmm5, %xmm5
; AVX1-NEXT:    vpunpcklbw {{.*#+}} xmm6 = xmm4[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; AVX1-NEXT:    vpsraw $8, %xmm6, %xmm6
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm6, %xmm6
; AVX1-NEXT:    vpsrlw $8, %xmm6, %xmm6
; AVX1-NEXT:    vpackuswb %xmm5, %xmm6, %xmm5
; AVX1-NEXT:    vpsrlw $7, %xmm4, %xmm4
; AVX1-NEXT:    vpand %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vpaddb %xmm3, %xmm5, %xmm3
; AVX1-NEXT:    vpunpckhbw {{.*#+}} xmm4 = xmm3[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm4, %xmm4
; AVX1-NEXT:    vpand %xmm1, %xmm4, %xmm4
; AVX1-NEXT:    vpmovzxbw {{.*#+}} xmm3 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero,xmm3[4],zero,xmm3[5],zero,xmm3[6],zero,xmm3[7],zero
; AVX1-NEXT:    vpmullw {{.*}}(%rip), %xmm3, %xmm3
; AVX1-NEXT:    vpand %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpackuswb %xmm4, %xmm1, %xmm1
; AVX1-NEXT:    vpsubb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2NOBW-LABEL: test_remconstant_32i8:
; AVX2NOBW:       # %bb.0:
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm1 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm1, %ymm2
; AVX2NOBW-NEXT:    vmovdqa {{.*#+}} ymm1 = [255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255]
; AVX2NOBW-NEXT:    vpand %ymm1, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm3 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpand %ymm1, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpackuswb %ymm2, %ymm3, %ymm2
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm3 = ymm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm4 = ymm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm4, %ymm4
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm4, %ymm4
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm4, %ymm4
; AVX2NOBW-NEXT:    vpackuswb %ymm3, %ymm4, %ymm3
; AVX2NOBW-NEXT:    vpaddb %ymm2, %ymm3, %ymm2
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm3 = ymm2[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm4 = ymm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpsraw $8, %ymm4, %ymm4
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm4, %ymm4
; AVX2NOBW-NEXT:    vpsrlw $8, %ymm4, %ymm4
; AVX2NOBW-NEXT:    vpackuswb %ymm3, %ymm4, %ymm3
; AVX2NOBW-NEXT:    vpsrlw $7, %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpand {{.*}}(%rip), %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpaddb %ymm2, %ymm3, %ymm2
; AVX2NOBW-NEXT:    vpunpckhbw {{.*#+}} ymm3 = ymm2[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,24,24,25,25,26,26,27,27,28,28,29,29,30,30,31,31]
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpand %ymm1, %ymm3, %ymm3
; AVX2NOBW-NEXT:    vpunpcklbw {{.*#+}} ymm2 = ymm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23]
; AVX2NOBW-NEXT:    vpmullw {{.*}}(%rip), %ymm2, %ymm2
; AVX2NOBW-NEXT:    vpand %ymm1, %ymm2, %ymm1
; AVX2NOBW-NEXT:    vpackuswb %ymm3, %ymm1, %ymm1
; AVX2NOBW-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; AVX2NOBW-NEXT:    retq
;
; AVX512BW-LABEL: test_remconstant_32i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovzxbw {{.*#+}} zmm1 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero,ymm0[16],zero,ymm0[17],zero,ymm0[18],zero,ymm0[19],zero,ymm0[20],zero,ymm0[21],zero,ymm0[22],zero,ymm0[23],zero,ymm0[24],zero,ymm0[25],zero,ymm0[26],zero,ymm0[27],zero,ymm0[28],zero,ymm0[29],zero,ymm0[30],zero,ymm0[31],zero
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovwb %zmm1, %ymm1
; AVX512BW-NEXT:    vpmovsxbw %ymm0, %zmm2
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpsrlw $8, %zmm2, %zmm2
; AVX512BW-NEXT:    vpmovwb %zmm2, %ymm2
; AVX512BW-NEXT:    vpaddb %ymm1, %ymm2, %ymm1
; AVX512BW-NEXT:    vpsrlw $7, %ymm1, %ymm2
; AVX512BW-NEXT:    vpand {{.*}}(%rip), %ymm2, %ymm2
; AVX512BW-NEXT:    vpmovsxbw %ymm1, %zmm1
; AVX512BW-NEXT:    vpsravw {{.*}}(%rip), %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovwb %zmm1, %ymm1
; AVX512BW-NEXT:    vpaddb %ymm2, %ymm1, %ymm1
; AVX512BW-NEXT:    vpmovzxbw {{.*#+}} zmm1 = ymm1[0],zero,ymm1[1],zero,ymm1[2],zero,ymm1[3],zero,ymm1[4],zero,ymm1[5],zero,ymm1[6],zero,ymm1[7],zero,ymm1[8],zero,ymm1[9],zero,ymm1[10],zero,ymm1[11],zero,ymm1[12],zero,ymm1[13],zero,ymm1[14],zero,ymm1[15],zero,ymm1[16],zero,ymm1[17],zero,ymm1[18],zero,ymm1[19],zero,ymm1[20],zero,ymm1[21],zero,ymm1[22],zero,ymm1[23],zero,ymm1[24],zero,ymm1[25],zero,ymm1[26],zero,ymm1[27],zero,ymm1[28],zero,ymm1[29],zero,ymm1[30],zero,ymm1[31],zero
; AVX512BW-NEXT:    vpmullw {{.*}}(%rip), %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovwb %zmm1, %ymm1
; AVX512BW-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; AVX512BW-NEXT:    retq
  %res = srem <32 x i8> %a, <i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15, i8 16, i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 22, i8 21, i8 20, i8 19, i8 18, i8 17, i8 16, i8 15, i8 14, i8 13, i8 12, i8 11, i8 10, i8 9, i8 8, i8 7>
  ret <32 x i8> %res
}
