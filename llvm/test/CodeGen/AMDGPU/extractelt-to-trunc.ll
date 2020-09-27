; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=amdgcn-- -verify-machineinstrs | FileCheck %s -check-prefix=GCN

declare i32 @llvm.amdgcn.workitem.id.x() nounwind readnone

; Make sure the add and load are reduced to 32-bits even with the
; bitcast to vector.
define amdgpu_kernel void @bitcast_int_to_vector_extract_0(i32 addrspace(1)* %out, i64 addrspace(1)* %in, i64 %b) {
; GCN-LABEL: bitcast_int_to_vector_extract_0:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GCN-NEXT:    s_load_dword s12, s[0:1], 0xd
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s10, 0
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_mov_b32 s11, s3
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b64 s[8:9], s[6:7]
; GCN-NEXT:    buffer_load_dword v0, v[0:1], s[8:11], 0 addr64
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_mov_b32 s0, s4
; GCN-NEXT:    s_mov_b32 s1, s5
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v0, vcc, s12, v0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
   %tid = call i32 @llvm.amdgcn.workitem.id.x()
   %gep = getelementptr i64, i64 addrspace(1)* %in, i32 %tid
   %a = load i64, i64 addrspace(1)* %gep
   %add = add i64 %a, %b
   %val.bc = bitcast i64 %add to <2 x i32>
   %extract = extractelement <2 x i32> %val.bc, i32 0
   store i32 %extract, i32 addrspace(1)* %out
   ret void
}

define amdgpu_kernel void @bitcast_fp_to_vector_extract_0(i32 addrspace(1)* %out, double addrspace(1)* %in, double %b) {
; GCN-LABEL: bitcast_fp_to_vector_extract_0:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GCN-NEXT:    s_load_dwordx2 s[12:13], s[0:1], 0xd
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s10, 0
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_mov_b32 s11, s3
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b64 s[8:9], s[6:7]
; GCN-NEXT:    buffer_load_dwordx2 v[0:1], v[0:1], s[8:11], 0 addr64
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_mov_b32 s0, s4
; GCN-NEXT:    s_mov_b32 s1, s5
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_f64 v[0:1], v[0:1], s[12:13]
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
   %tid = call i32 @llvm.amdgcn.workitem.id.x()
   %gep = getelementptr double, double addrspace(1)* %in, i32 %tid
   %a = load double, double addrspace(1)* %gep
   %add = fadd double %a, %b
   %val.bc = bitcast double %add to <2 x i32>
   %extract = extractelement <2 x i32> %val.bc, i32 0
   store i32 %extract, i32 addrspace(1)* %out
   ret void
}

define amdgpu_kernel void @bitcast_int_to_fpvector_extract_0(float addrspace(1)* %out, i64 addrspace(1)* %in, i64 %b) {
; GCN-LABEL: bitcast_int_to_fpvector_extract_0:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GCN-NEXT:    s_load_dwordx2 s[12:13], s[0:1], 0xd
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s10, 0
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_mov_b32 s11, s3
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b64 s[8:9], s[6:7]
; GCN-NEXT:    buffer_load_dwordx2 v[0:1], v[0:1], s[8:11], 0 addr64
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_mov_b32 s0, s4
; GCN-NEXT:    s_mov_b32 s1, s5
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v0, vcc, s12, v0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
   %tid = call i32 @llvm.amdgcn.workitem.id.x()
   %gep = getelementptr i64, i64 addrspace(1)* %in, i32 %tid
   %a = load i64, i64 addrspace(1)* %gep
   %add = add i64 %a, %b
   %val.bc = bitcast i64 %add to <2 x float>
   %extract = extractelement <2 x float> %val.bc, i32 0
   store float %extract, float addrspace(1)* %out
   ret void
}

define amdgpu_kernel void @no_extract_volatile_load_extract0(i32 addrspace(1)* %out, <4 x i32> addrspace(1)* %in) {
; GCN-LABEL: no_extract_volatile_load_extract0:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    s_mov_b32 s10, s6
; GCN-NEXT:    s_mov_b32 s11, s7
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s8, s2
; GCN-NEXT:    s_mov_b32 s9, s3
; GCN-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; GCN-NEXT:    s_mov_b32 s4, s0
; GCN-NEXT:    s_mov_b32 s5, s1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GCN-NEXT:    s_endpgm
entry:
  %vec = load volatile <4 x i32>, <4 x i32> addrspace(1)* %in
  %elt0 = extractelement <4 x i32> %vec, i32 0
  store i32 %elt0, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @no_extract_volatile_load_extract2(i32 addrspace(1)* %out, <4 x i32> addrspace(1)* %in) {
; GCN-LABEL: no_extract_volatile_load_extract2:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    s_mov_b32 s10, s6
; GCN-NEXT:    s_mov_b32 s11, s7
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s8, s2
; GCN-NEXT:    s_mov_b32 s9, s3
; GCN-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; GCN-NEXT:    s_mov_b32 s4, s0
; GCN-NEXT:    s_mov_b32 s5, s1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    buffer_store_dword v2, off, s[4:7], 0
; GCN-NEXT:    s_endpgm
entry:
  %vec = load volatile <4 x i32>, <4 x i32> addrspace(1)* %in
  %elt2 = extractelement <4 x i32> %vec, i32 2
  store i32 %elt2, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @no_extract_volatile_load_dynextract(i32 addrspace(1)* %out, <4 x i32> addrspace(1)* %in, i32 %idx) {
; GCN-LABEL: no_extract_volatile_load_dynextract:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_load_dword s12, s[0:1], 0xd
; GCN-NEXT:    s_mov_b32 s10, s2
; GCN-NEXT:    s_mov_b32 s11, s3
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s8, s6
; GCN-NEXT:    s_mov_b32 s9, s7
; GCN-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; GCN-NEXT:    s_mov_b32 s0, s4
; GCN-NEXT:    s_mov_b32 s1, s5
; GCN-NEXT:    v_cmp_eq_u32_e64 vcc, s12, 1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_cmp_eq_u32_e64 vcc, s12, 2
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; GCN-NEXT:    v_cmp_eq_u32_e64 vcc, s12, 3
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v3, vcc
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
entry:
  %vec = load volatile <4 x i32>, <4 x i32> addrspace(1)* %in
  %eltN = extractelement <4 x i32> %vec, i32 %idx
  store i32 %eltN, i32 addrspace(1)* %out
  ret void
}
