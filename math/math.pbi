;
; MATH
;
; a module for vectors and matrices calculation
; translated by GPI
;
; Based on GLM
; https://github.com/g-truc/glm
;
; Change log:
;   1.1:  
;         - add rotate_float, translate_float, scale_float - replace the vector with floats
;         - replaced many macros with procedures and all procedures returns now the *res-pointer. this allows nested calls
;           like vec3_mul(res, vec3_add(a, b,c), a) equals "a=b+c: res=a*a" equals "res = (b+c)*(b+c)"
;         - add many vec2_*, vec3_*, vec4_* for dot, length, normalize and so on
;         - add this comment
;         - add "euler_angles" from glm
;   1.0:  
;         - first release
;
; ================================================================================
; OpenGL Mathematics (GLM)
; --------------------------------------------------------------------------------
; GLM is licensed under The Happy Bunny License or MIT License
;
; ================================================================================
; The Happy Bunny License (Modified MIT License)
; --------------------------------------------------------------------------------
; Copyright (c) 2005 - G-Truc Creation
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; Restrictions:
;  By making use of the Software for military purposes, you choose to make a
;  Bunny unhappy.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
; THE SOFTWARE.
;
; ================================================================================
; The MIT License
; --------------------------------------------------------------------------------
; Copyright (c) 2005 - G-Truc Creation
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
; THE SOFTWARE.
;
XIncludeFile "_declare__math_.pbi"
DeclareModule math
  EnableExplicit  
  Macro GetType(nb)
(((TypeOf(nb\__type0__)&1)<<0) +((TypeOf(nb\__type1__)&1)<<1) +((TypeOf(nb\__type2__)&1)<<2) + ((TypeOf(nb\__type3__)&1)<<3))
    ;+ _math_::_typehelper2(nb,4) + _math_::_typehelper2(nb,5) + _math_::_typehelper2(nb,6) + _math_::_typehelper2(nb,7))
  EndMacro
;-----------------------
;- constants.pbi
;{

#epsilon            = 1.192092896e-07 ; float-Epsilon!
#zero               = 0
#one                = 1
#PI                 = 3.1415926535897932384
#two_pi             = 6.2831853071795864769
#root_pi            = 1.772453850905516027
#half_pi            = 1.5707963267948966192
#three_over_two_pi  = 4.7123889803846898577
#quarter_pi         = 0.7853981633974483096
#one_over_pi        = 0.3183098861837906715
#one_over_two_pi    = 0.1591549430918953358
#two_over_pi        = 0.6366197723675813431
#four_over_pi       = 1.2732395447351626862
#two_over_root_pi   = 1.1283791670955125739
#one_over_root_two  = 0.7071067811865475244
#root_half_pi       = 1.253314137315500251
#root_two_pi        = 2.506628274631000502
#root_ln_four       = 1.17741002251547469
#E                  = 2.7182818284590452354
#euler              = 0.5772156649015328606
#root_two           = 1.4142135623730950488
#root_three         = 1.7320508075688772935
#root_five          = 2.2360679774997896964
#ln_two             = 0.6931471805599453094
#ln_ten             = 2.3025850929940456840
#ln_ln_two          = -0.3665129205816643
#third              = 0.3333333333333333333
#two_thirds         = 0.6666666666666666667
#golden_ratio       = 1.6180339887498948482
#FLT_MIN            = 1.175494351e-38
#FLT_MAX            = 3.402823466e+38
#cos_one_over_two   = 0.8775825618903727161
;}
;-----------------------
;- vector.pbi
;{

;type must be smaller than 4!
Enumeration type
  #type_vec2 = 2
  #type_vec3 = 3
  #type_vec4 = 4
  #type_vecmax
EndEnumeration
Structure vec2
  _math_::StructureAddType(#type_vec2)
  StructureUnion
    x.f
    r.f
    s.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    y.f
    g.f
    t.f
  EndStructureUnion
EndStructure
Structure vec3
  _math_::StructureAddType(#type_vec3)
  StructureUnion
    x.f
    r.f
    s.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    y.f
    g.f
    t.f
  EndStructureUnion
  StructureUnion
    z.f
    b.f
    p.f
  EndStructureUnion
EndStructure
Structure vec4
  _math_::StructureAddType(#type_vec4)
  StructureUnion
    x.f
    r.f
    s.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    y.f
    g.f
    t.f
  EndStructureUnion
  StructureUnion
    z.f
    b.f
    p.f
  EndStructureUnion
  StructureUnion
    w.f
    a.f
    q.f
  EndStructureUnion
EndStructure
Structure vec2l
  _math_::StructureAddType(#type_vec2)
  StructureUnion
    x.l
    r.l
    s.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    y.l
    g.l
    t.l
  EndStructureUnion
EndStructure
Structure vec3l
  _math_::StructureAddType(#type_vec3)
  StructureUnion
    x.l
    r.l
    s.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    y.l
    g.l
    t.l
  EndStructureUnion
  StructureUnion
    z.l
    b.l
    p.l
  EndStructureUnion
EndStructure
Structure vec4l
  _math_::StructureAddType(#type_vec4)
  StructureUnion
    x.l
    r.l
    s.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    y.l
    g.l
    t.l
  EndStructureUnion
  StructureUnion
    z.l
    b.l
    p.l
  EndStructureUnion
  StructureUnion
    w.l
    a.l
    q.l
  EndStructureUnion
EndStructure
Structure vec2Array
  v.vec2[0]
EndStructure
Structure vec3Array
  v.vec3[0]
EndStructure
Structure vec4Array
  v.vec4[0]
EndStructure
;}
;-----------------------
;- type_vector.pbi
;{

Macro vec2_const(label,xf,yf)
  DataSection
    label:
    Data.f xf, yf
  EndDataSection
EndMacro
Macro vec2_let_Func(res, func, v)
  res\x = func( v\x )
  res\y = func( v\y )
EndMacro
Macro vec2_let_Func2(res, func, v1, v2)
  res\x = func( v1\x, v2\x )
  res\y = func( v1\y, v2\y )
EndMacro
Macro vec2_let_Func2_Scalar(res, func, v1, s)
  res\x = func( v1\x, (s) )
  res\y = func( v1\y, (s) )
EndMacro
Macro vec3_const(label, xf, yf, zf)
  DataSection
    label:
    Data.f xf, yf, zf
  EndDataSection
EndMacro
Macro vec3_let_Func(res, func, v)
  res\x = func( v\x )
  res\y = func( v\y )
  res\z = func( v\z )
EndMacro
Macro vec3_let_Func2(res, func, v1, v2)
  res\x = func( v1\x, v2\x )
  res\y = func( v1\y, v2\y )
  res\z = func( v1\z, v2\z )
EndMacro
Macro vec3_let_Func2_Scalar(res, func, v1, s)
  res\x = func( v1\x, (s) )
  res\y = func( v1\y, (s) )
  res\z = func( v1\z, (s) )
EndMacro
Macro vec4_const(label, xf, yf, zf, wf)
  DataSection
    label:
    Data.f xf, yf, zf, wf
  EndDataSection
EndMacro
Macro vec4_let_Func(res, func, v)
  res\x = func( v\x )
  res\y = func( v\y )
  res\z = func( v\z )
  res\w = func( v\w )
EndMacro
Macro vec4_let_Func2(res, func, v1, v2)
  res\x = func( v1\x, v2\x )
  res\y = func( v1\y, v2\y )
  res\z = func( v1\z, v2\z )
  res\w = func( v1\w, v2\w )
EndMacro
Macro vec4_let_Func2_scalar(res, func, v1, s)
  res\x = func( v1\x, (s) )
  res\y = func( v1\y, (s) )
  res\z = func( v1\z, (s) )
  res\w = func( v1\w, (s) )
EndMacro
Declare vec2_set_float(*res.vec2, x.f=0.0, y.f=0.0)
Declare vec2_set_Scalar(*res.vec2, s.f)
Declare vec2_set(*res.vec2, *v.vec2)
Declare vec2_set_vec3(*res.vec2, *v.vec3)
Declare vec2_set_vec4(*res.vec2, *v.vec4)
Declare vec2_add(*res.vec2, *v1.vec2, *v2.vec2)
Declare vec2_sub(*res.vec2, *v1.vec2, *v2.vec2)
Declare vec2_mul(*res.vec2, *v1.vec2, *v2.vec2)
Declare vec2_div(*res.vec2, *v1.vec2, *v2.vec2)
Declare vec2_add_scalar(*res.vec2, *v1.vec2, s.f)
Declare vec2_sub_scalar(*res.vec2, *v1.vec2, s.f)
Declare vec2_mul_scalar(*res.vec2, *v1.vec2, s.f)
Declare vec2_div_scalar(*res.vec2, *v1.vec2, s.f)
Declare scalar_add_vec2(*res.vec2, s.f, *v1.vec2)
Declare scalar_sub_vec2(*res.vec2, s.f, *v1.vec2)
Declare scalar_mul_vec2(*res.vec2, s.f, *v1.vec2)
Declare scalar_div_vec2(*res.vec2, s.f, *v1.vec2)
Declare.l vec2_isEqual(*v1.vec2, *v2.vec2)
Declare vec3_set_float(*res.vec3, x.f=0.0, y.f=0.0, z.f=0.0)
Declare vec3_set_Scalar(*res.vec3, s.f)
Declare vec3_set_vec2(*res.vec3, *v.vec2, f.f)
Declare vec3_set(*res.vec3, *v.vec3)
Declare vec3_set_vec4(*res.vec3, *v.vec4)
Declare vec3_add(*res.vec3, *v1.vec3, *v2.vec3)
Declare vec3_sub(*res.vec3, *v1.vec3, *v2.vec3)
Declare vec3_mul(*res.vec3, *v1.vec3, *v2.vec3)
Declare vec3_div(*res.vec3, *v1.vec3, *v2.vec3)
Declare vec3_add_scalar(*res.vec3, *v1.vec3, s.f)
Declare vec3_sub_scalar(*res.vec3, *v1.vec3, s.f)
Declare vec3_mul_scalar(*res.vec3, *v1.vec3, s.f)
Declare vec3_div_scalar(*res.vec3, *v1.vec3, s.f)
Declare scalar_add_vec3(*res.vec3, s.f, *v1.vec3)
Declare scalar_sub_vec3(*res.vec3, s.f, *v1.vec3)
Declare scalar_mul_vec3(*res.vec3, s.f, *v1.vec3)
Declare scalar_div_vec3(*res.vec3, s.f, *v1.vec3)
Declare.l vec3_isEqual(*v1.vec3, *v2.vec3)
Declare vec4_set_float(*res.vec4, x.f=0.0, y.f=0.0, z.f=0.0, w.f=0.0)
Declare vec4_set_Scalar(*res.vec4, s.f)
Declare vec4_set_vec2(*res.vec4, *v1.vec2, *v2.vec2)
Declare vec4_set_vec3(*res.vec4, *v.vec3, f.f)
Declare vec4_set(*res.vec4, *v.vec4)
Declare vec4_add(*res.vec4, *v1.vec4, *v2.vec4)
Declare vec4_sub(*res.vec4, *v1.vec4, *v2.vec4)
Declare vec4_mul(*res.vec4, *v1.vec4, *v2.vec4)
Declare vec4_div(*res.vec4, *v1.vec4, *v2.vec4)
Declare vec4_add_scalar(*res.vec4, *v1.vec4, s.f)
Declare vec4_sub_scalar(*res.vec4, *v1.vec4, s.f)
Declare vec4_mul_scalar(*res.vec4, *v1.vec4, s.f)
Declare vec4_div_scalar(*res.vec4, *v1.vec4, s.f)
Declare scalar_add_vec4(*res.vec4, s.f, *v1.vec4)
Declare scalar_sub_vec4(*res.vec4, s.f, *v1.vec4)
Declare scalar_mul_vec4(*res.vec4, s.f, *v1.vec4)
Declare scalar_div_vec4(*res.vec4, s.f, *v1.vec4)
Declare.l vec4_isEqual(*v1.vec4, *v2.vec4)
;}
;-----------------------
;- func_exponential.pbi
;{

Declare.f pow_f(a.f,b.f)
Declare.f exp_f(a.f)
Declare.f log_f(a.f)
Declare.f exp2_f(value.f)
Declare.f log2_f(value.f)
Declare.f sqrt_f(a.f)
Declare.f inversesqrt_f(f.f)
Macro inversesqrt(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@inversesqrt_f(), v)
EndMacro
Macro Pow(res, base, exponent)
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@pow_f(), base, exponent)
EndMacro
Macro Exp(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@exp_f(), x)
EndMacro
Macro Log(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@log_f(), x)
EndMacro
Macro Exp2(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@exp2_f(), x)
EndMacro
Macro Log2(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@log2_f(), x)
EndMacro
Macro sqrt(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sqrt_f(), x)
EndMacro
Macro Vec2_inversesqrt(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@inversesqrt_f(), v)
EndMacro
Macro Vec2_Pow(res, base, exponent)
  _math::compute_function2(res, math::#type_vec2, math::@pow_f(), base, exponent)
EndMacro
Macro Vec2_Exp(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@exp_f(), x)
EndMacro
Macro Vec2_Log(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@log_f(), x)
EndMacro
Macro Vec2_Exp2(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@exp2_f(), x)
EndMacro
Macro Vec2_Log2(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@log2_f(), x)
EndMacro
Macro Vec2_sqrt(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@sqrt_f(), x)
EndMacro
Macro Vec3_inversesqrt(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@inversesqrt_f(), v)
EndMacro
Macro Vec3_Pow(res, base, exponent)
  _math::compute_function2(res, math::#type_vec3, math::@pow_f(), base, exponent)
EndMacro
Macro Vec3_Exp(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@exp_f(), x)
EndMacro
Macro Vec3_Log(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@log_f(), x)
EndMacro
Macro Vec3_Exp2(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@exp2_f(), x)
EndMacro
Macro Vec3_Log2(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@log2_f(), x)
EndMacro
Macro Vec3_sqrt(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@sqrt_f(), x)
EndMacro
Macro Vec4_inversesqrt(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@inversesqrt_f(), v)
EndMacro
Macro Vec4_Pow(res, base, exponent)
  _math::compute_function2(res, math::#type_vec4, math::@pow_f(), base, exponent)
EndMacro
Macro Vec4_Exp(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@exp_f(), x)
EndMacro
Macro Vec4_Log(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@log_f(), x)
EndMacro
Macro Vec4_Exp2(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@exp2_f(), x)
EndMacro
Macro Vec4_Log2(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@log2_f(), x)
EndMacro
Macro Vec4_sqrt(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@sqrt_f(), x)
EndMacro
;}
;-----------------------
;- func_common.pbi
;{

Declare.f frexp_f(value.f, *exp.float)
Declare.f ldexp_f(x.f,expf.f)
Declare.f Modf_f(x.f, *retI.float)
Declare.f Mod_f(a.f, b.f)
Declare.f clamp_f(x.f, min.f=0, max.f=1)
Declare.f repeat_f(Texcoord.f)
Declare.f mirrorClamp_f(Texcoord.f)
Declare.f mirrorRepeat_f(Texcoord.f)
Declare.f Trunc_f(x.f)
Declare.f fract_f(x.f)
Declare.f mix_f(x.f, y.f, a.f)
Declare.f roundEven_f(x.f)
Declare.l equal_f(x.f,y.f,epsilon.f = #epsilon)
Declare.l notEqual_f(x.f,y.f,epsilon.f = #epsilon)
Declare.f Round_f(x.f)
Declare.f Floor_f(x.f)
Declare.f Ceil_f(x.f)
Declare.f Abs_f(x.f)
Declare.f sign_f(x.f)
Macro Modf(res, v, Resi)
_math::compute_function2p(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@modf_f(), v, Resi)
EndMacro
Macro frexp(res, v, Resi)
_math::compute_function2p(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@frexp_f(), v, Resi)
EndMacro
Macro ldexp(res, x, exp)
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@ldexp_f(), x, exp)
EndMacro
Macro Abs(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@abs_f(), x)
EndMacro
Macro Sign(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sign_f(), x)
EndMacro
Macro Floor(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@Floor_f(), x)
EndMacro
Macro Ceil(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@Ceil_f(), x)
EndMacro
Macro fract(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@fract_f(), x)
EndMacro
Macro roundEven(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@roundEven_f(), x)
EndMacro
Macro trunc(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@trunc_f(), x)
EndMacro
Macro Round(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@round_f(), x)
EndMacro
Macro Mod(res, x, y)
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@mod_f(), x, y)
EndMacro
Macro Mod_Scalar(res, x, scalar)
_math::compute_function2s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@mod_f(), x, scalar)
EndMacro
Macro min(res, x, y)
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@min2_f(), x, y)
EndMacro
Macro min_Scalar(res, x, scalar)
_math::compute_function2s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@min2_f(), x, scalar)
EndMacro
Macro max(res, x, y)
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@max2_f(), x, y)
EndMacro
Macro max_Scalar(res, x, scalar)
_math::compute_function2s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), _math::@max2_f(), x, scalar)
EndMacro
Macro clamp(res, x, y, z)
_math::compute_function3(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@clamp_f(), x, y, z)
EndMacro
Macro clamp_Scalar(res, x, min=0, max=1)
_math::compute_function3s(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@clamp_f(), x, min, max)
EndMacro
Macro Repeat(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@repeat_f(), x)
EndMacro
Macro mirrorClamp(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@repeat_f(), x)
EndMacro
Macro mirrorRepeat(res, x)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@repeat_f(), x)
EndMacro
Macro vec_Step(res, edge, x)
_math::vec_Step_Vector(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edge, x)
EndMacro
Macro vec_Step_Scalar(res, edgeScalar, x)
_math::vec_Step_Vector_Scalar(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edgeScalar, x)
EndMacro
Macro smoothstep(res, edge0, edge1, x)
_math::vec_smoothstep_vector(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edge0, edge1, x)
EndMacro
Macro smoothstep_Scalar(res, edge0Scalar, edge1Scalar, x)
_math::vec_smoothstep_vector_Scalar(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), edge0Scalar, edge1Scalar, x)
EndMacro
Macro string(x,nbdecimals = 2)
_math::string(x,(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)), nbdecimals)
EndMacro
Macro stringBool(x)
_math::stringBool(x,(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)))
EndMacro
Macro IsNAN(resBool, x)
_math::is_Nan(resbool,(((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) + ((TypeOf(resbool\__type3__)&1)<<3)), x)
EndMacro
Macro isInf(resBool, x)
_math::is_Inf(resbool,(((TypeOf(resbool\__type0__)&1)<<0) +((TypeOf(resbool\__type1__)&1)<<1) +((TypeOf(resbool\__type2__)&1)<<2) + ((TypeOf(resbool\__type3__)&1)<<3)), x)
EndMacro
Macro any(bool)
_math::bool_any(bool,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)))
EndMacro
Macro all(bool)
_math::bool_all(bool,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)))
EndMacro
Macro Bool_not(resBool, Bool)
_math::Bool_not(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),bool)
EndMacro
Macro Bool_and(resBool, Bool)
_math::Bool_and(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),bool)
EndMacro
Macro Bool_or(resBool, Bool)
_math::Bool_or(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),bool)
EndMacro
Macro equal(resBool, x, y, epsilon = math::#epsilon)
_math::equal(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro notEqual(resBool, x, y, epsilon = math::#epsilon)
_math::notEqual(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro all_equal( x, y, epsilon = math::#epsilon)
_math::do_all(_math::@equal(),(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro any_notEqual( x, y, epsilon = math::#epsilon)
_math::do_any(_math::@notEqual(),(((TypeOf(x\__type0__)&1)<<0) +((TypeOf(x\__type1__)&1)<<1) +((TypeOf(x\__type2__)&1)<<2) + ((TypeOf(x\__type3__)&1)<<3)),x,y,epsilon)
EndMacro
Macro lessThan(resBool, x, y)
_math::lessThan(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro lessThanEqual(resBool, x, y)
_math::lessThanEqual(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro greaterThan(resBool, x, y)
_math::greaterThan(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro greaterThanEqual(resBool, x, y)
_math::greaterThanEqual(resBool,(((TypeOf(resBool\__type0__)&1)<<0) +((TypeOf(resBool\__type1__)&1)<<1) +((TypeOf(resBool\__type2__)&1)<<2) + ((TypeOf(resBool\__type3__)&1)<<3)),x,y)
EndMacro
Macro long_from_float(bool,matvec)
_math::long_from_float(bool,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)),matvec)
EndMacro
Macro float_from_long(matvec, bool)
_math::float_from_long(matvec,(((TypeOf(bool\__type0__)&1)<<0) +((TypeOf(bool\__type1__)&1)<<1) +((TypeOf(bool\__type2__)&1)<<2) + ((TypeOf(bool\__type3__)&1)<<3)), bool)
EndMacro
Macro mix_Scalar(res, x, y, A)
_math::compute_mix_scalar(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), x, y, a)
EndMacro
Macro mix(res, x, y, A)  
_math::compute_mix(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), x, y, a)
EndMacro
Macro min_f(a,b,c=NaN(), d=NaN())
  _math::min_f(a,b,c,d)
EndMacro
Macro max_f(a,b,c=NaN(), d=NaN())
  _math::max_f(a,b,c,d)
EndMacro
Macro Vec2_Modf(res, v, Resi)
  _math::compute_function2p(res, math::#type_vec2, math::@modf_f(), v, Resi)
EndMacro
Macro Vec2_frexp(res, v, Resi)
  _math::compute_function2p(res, math::#type_vec2, math::@frexp_f(), v, Resi)
EndMacro
Macro Vec2_ldexp(res, x, exp)
  _math::compute_function2(res, math::#type_vec2, math::@ldexp_f(), x, exp)
EndMacro
Macro Vec2_Abs(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@abs_f(), x)
EndMacro
Macro Vec2_Sign(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@sign_f(), x)
EndMacro
Macro Vec2_Floor(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@Floor_f(), x)
EndMacro
Macro Vec2_Ceil(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@Ceil_f(), x)
EndMacro
Macro Vec2_fract(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@fract_f(), x)
EndMacro
Macro Vec2_roundEven(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@roundEven_f(), x)
EndMacro
Macro Vec2_trunc(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@trunc_f(), x)
EndMacro
Macro Vec2_Round(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@round_f(), x)
EndMacro
Macro Vec2_Mod(res, x, y)
  _math::compute_function2(res, math::#type_vec2, math::@mod_f(), x, y)
EndMacro
Macro Vec2_Mod_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec2, math::@mod_f(), x, scalar)
EndMacro
Macro Vec2_min(res, x, y)
  _math::compute_function2(res, math::#type_vec2, _math::@min2_f(), x, y)
EndMacro
Macro Vec2_min_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec2, _math::@min2_f(), x, scalar)
EndMacro
Macro Vec2_max(res, x, y)
  _math::compute_function2(res, math::#type_vec2, _math::@max2_f(), x, y)
EndMacro
Macro Vec2_max_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec2, _math::@max2_f(), x, scalar)
EndMacro
Macro Vec2_clamp(res, x, y, z)
  _math::compute_function3(res, math::#type_vec2, math::@clamp_f(), x, y, z)
EndMacro
Macro Vec2_clamp_Scalar(res, x, min=0, max=1)
  _math::compute_function3s(res, math::#type_vec2, math::@clamp_f(), x, min, max)
EndMacro
Macro Vec2_Repeat(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@repeat_f(), x)
EndMacro
Macro Vec2_mirrorClamp(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@repeat_f(), x)
EndMacro
Macro Vec2_mirrorRepeat(res, x)
  _math::compute_function1(res, math::#type_vec2, math::@repeat_f(), x)
EndMacro
Macro Vec2_vec_Step(res, edge, x)
  _math::vec_Step_Vector(res, math::#type_vec2, edge, x)
EndMacro
Macro Vec2_vec_Step_Scalar(res, edgeScalar, x)
  _math::vec_Step_Vector_Scalar(res, math::#type_vec2, edgeScalar, x)
EndMacro
Macro Vec2_smoothstep(res, edge0, edge1, x)
  _math::vec_smoothstep_vector(res, math::#type_vec2, edge0, edge1, x)
EndMacro
Macro Vec2_smoothstep_Scalar(res, edge0Scalar, edge1Scalar, x)
  _math::vec_smoothstep_vector_Scalar(res, math::#type_vec2, edge0Scalar, edge1Scalar, x)
EndMacro
Macro Vec2_string(x,nbdecimals = 2)
  _math::string(x, math::#type_vec2, nbdecimals)
EndMacro
Macro Vec2_stringBool(x)
  _math::stringBool(x, math::#type_vec2)
EndMacro
Macro Vec2_IsNAN(resBool, x)
  _math::is_Nan(resbool, math::#type_vec2, x)
EndMacro
Macro Vec2_isInf(resBool, x)
  _math::is_Inf(resbool, math::#type_vec2, x)
EndMacro
Macro Vec2_any(bool)
  _math::bool_any(bool,math::#type_vec2)
EndMacro
Macro Vec2_all(bool)
  _math::bool_all(bool,math::#type_vec2)
EndMacro
Macro Vec2_Bool_not(resBool, Bool)
  _math::Bool_not(resBool,math::#type_vec2,bool)
EndMacro
Macro Vec2_Bool_and(resBool, Bool)
  _math::Bool_and(resBool,math::#type_vec2,bool)
EndMacro
Macro Vec2_Bool_or(resBool, Bool)
  _math::Bool_or(resBool,math::#type_vec2,bool)
EndMacro
Macro Vec2_equal(resBool, x, y, epsilon = math::#epsilon)
  _math::equal(resBool,math::#type_vec2,x,y,epsilon)
EndMacro
Macro Vec2_notEqual(resBool, x, y, epsilon = math::#epsilon)
  _math::notEqual(resBool,math::#type_vec2,x,y,epsilon)
EndMacro
Macro Vec2_all_equal( x, y, epsilon = math::#epsilon)
  _math::do_all(_math::@equal(),math::#type_vec2,x,y,epsilon)
EndMacro
Macro Vec2_any_notEqual( x, y, epsilon = math::#epsilon)
  _math::do_any(_math::@notEqual(),math::#type_vec2,x,y,epsilon)
EndMacro
Macro Vec2_lessThan(resBool, x, y)
  _math::lessThan(resBool,math::#type_vec2,x,y)
EndMacro
Macro Vec2_lessThanEqual(resBool, x, y)
  _math::lessThanEqual(resBool,math::#type_vec2,x,y)
EndMacro
Macro Vec2_greaterThan(resBool, x, y)
  _math::greaterThan(resBool,math::#type_vec2,x,y)
EndMacro
Macro Vec2_greaterThanEqual(resBool, x, y)
  _math::greaterThanEqual(resBool,math::#type_vec2,x,y)
EndMacro
Macro Vec2_long_from_float(bool,matvec)
  _math::long_from_float(bool,math::#type_vec2,matvec)
EndMacro
Macro Vec2_float_from_long(matvec, bool)
  _math::float_from_long(matvec,math::#type_vec2, bool)
EndMacro
Macro Vec2_mix_Scalar(res, x, y, A)
  _math::compute_mix_scalar(res, math::#type_vec2, x, y, a)
EndMacro
Macro Vec2_mix(res, x, y, A)
  _math::compute_mix(res, math::#type_vec2, x, y, a)
EndMacro
Macro Vec3_Modf(res, v, Resi)
  _math::compute_function2p(res, math::#type_vec3, math::@modf_f(), v, Resi)
EndMacro
Macro Vec3_frexp(res, v, Resi)
  _math::compute_function2p(res, math::#type_vec3, math::@frexp_f(), v, Resi)
EndMacro
Macro Vec3_ldexp(res, x, exp)
  _math::compute_function2(res, math::#type_vec3, math::@ldexp_f(), x, exp)
EndMacro
Macro Vec3_Abs(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@abs_f(), x)
EndMacro
Macro Vec3_Sign(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@sign_f(), x)
EndMacro
Macro Vec3_Floor(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@Floor_f(), x)
EndMacro
Macro Vec3_Ceil(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@Ceil_f(), x)
EndMacro
Macro Vec3_fract(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@fract_f(), x)
EndMacro
Macro Vec3_roundEven(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@roundEven_f(), x)
EndMacro
Macro Vec3_trunc(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@trunc_f(), x)
EndMacro
Macro Vec3_Round(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@round_f(), x)
EndMacro
Macro Vec3_Mod(res, x, y)
  _math::compute_function2(res, math::#type_vec3, math::@mod_f(), x, y)
EndMacro
Macro Vec3_Mod_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec3, math::@mod_f(), x, scalar)
EndMacro
Macro Vec3_min(res, x, y)
  _math::compute_function2(res, math::#type_vec3, _math::@min2_f(), x, y)
EndMacro
Macro Vec3_min_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec3, _math::@min2_f(), x, scalar)
EndMacro
Macro Vec3_max(res, x, y)
  _math::compute_function2(res, math::#type_vec3, _math::@max2_f(), x, y)
EndMacro
Macro Vec3_max_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec3, _math::@max2_f(), x, scalar)
EndMacro
Macro Vec3_clamp(res, x, y, z)
  _math::compute_function3(res, math::#type_vec3, math::@clamp_f(), x, y, z)
EndMacro
Macro Vec3_clamp_Scalar(res, x, min=0, max=1)
  _math::compute_function3s(res, math::#type_vec3, math::@clamp_f(), x, min, max)
EndMacro
Macro Vec3_Repeat(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@repeat_f(), x)
EndMacro
Macro Vec3_mirrorClamp(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@repeat_f(), x)
EndMacro
Macro Vec3_mirrorRepeat(res, x)
  _math::compute_function1(res, math::#type_vec3, math::@repeat_f(), x)
EndMacro
Macro Vec3_vec_Step(res, edge, x)
  _math::vec_Step_Vector(res, math::#type_vec3, edge, x)
EndMacro
Macro Vec3_vec_Step_Scalar(res, edgeScalar, x)
  _math::vec_Step_Vector_Scalar(res, math::#type_vec3, edgeScalar, x)
EndMacro
Macro Vec3_smoothstep(res, edge0, edge1, x)
  _math::vec_smoothstep_vector(res, math::#type_vec3, edge0, edge1, x)
EndMacro
Macro Vec3_smoothstep_Scalar(res, edge0Scalar, edge1Scalar, x)
  _math::vec_smoothstep_vector_Scalar(res, math::#type_vec3, edge0Scalar, edge1Scalar, x)
EndMacro
Macro Vec3_string(x,nbdecimals = 2)
  _math::string(x, math::#type_vec3, nbdecimals)
EndMacro
Macro Vec3_stringBool(x)
  _math::stringBool(x, math::#type_vec3)
EndMacro
Macro Vec3_IsNAN(resBool, x)
  _math::is_Nan(resbool, math::#type_vec3, x)
EndMacro
Macro Vec3_isInf(resBool, x)
  _math::is_Inf(resbool, math::#type_vec3, x)
EndMacro
Macro Vec3_any(bool)
  _math::bool_any(bool,math::#type_vec3)
EndMacro
Macro Vec3_all(bool)
  _math::bool_all(bool,math::#type_vec3)
EndMacro
Macro Vec3_Bool_not(resBool, Bool)
  _math::Bool_not(resBool,math::#type_vec3,bool)
EndMacro
Macro Vec3_Bool_and(resBool, Bool)
  _math::Bool_and(resBool,math::#type_vec3,bool)
EndMacro
Macro Vec3_Bool_or(resBool, Bool)
  _math::Bool_or(resBool,math::#type_vec3,bool)
EndMacro
Macro Vec3_equal(resBool, x, y, epsilon = math::#epsilon)
  _math::equal(resBool,math::#type_vec3,x,y,epsilon)
EndMacro
Macro Vec3_notEqual(resBool, x, y, epsilon = math::#epsilon)
  _math::notEqual(resBool,math::#type_vec3,x,y,epsilon)
EndMacro
Macro Vec3_all_equal( x, y, epsilon = math::#epsilon)
  _math::do_all(_math::@equal(),math::#type_vec3,x,y,epsilon)
EndMacro
Macro Vec3_any_notEqual( x, y, epsilon = math::#epsilon)
  _math::do_any(_math::@notEqual(),math::#type_vec3,x,y,epsilon)
EndMacro
Macro Vec3_lessThan(resBool, x, y)
  _math::lessThan(resBool,math::#type_vec3,x,y)
EndMacro
Macro Vec3_lessThanEqual(resBool, x, y)
  _math::lessThanEqual(resBool,math::#type_vec3,x,y)
EndMacro
Macro Vec3_greaterThan(resBool, x, y)
  _math::greaterThan(resBool,math::#type_vec3,x,y)
EndMacro
Macro Vec3_greaterThanEqual(resBool, x, y)
  _math::greaterThanEqual(resBool,math::#type_vec3,x,y)
EndMacro
Macro Vec3_long_from_float(bool,matvec)
  _math::long_from_float(bool,math::#type_vec3,matvec)
EndMacro
Macro Vec3_float_from_long(matvec, bool)
  _math::float_from_long(matvec,math::#type_vec3, bool)
EndMacro
Macro Vec3_mix_Scalar(res, x, y, A)
  _math::compute_mix_scalar(res, math::#type_vec3, x, y, a)
EndMacro
Macro Vec3_mix(res, x, y, A)
  _math::compute_mix(res, math::#type_vec3, x, y, a)
EndMacro
Macro Vec4_Modf(res, v, Resi)
  _math::compute_function2p(res, math::#type_vec4, math::@modf_f(), v, Resi)
EndMacro
Macro Vec4_frexp(res, v, Resi)
  _math::compute_function2p(res, math::#type_vec4, math::@frexp_f(), v, Resi)
EndMacro
Macro Vec4_ldexp(res, x, exp)
  _math::compute_function2(res, math::#type_vec4, math::@ldexp_f(), x, exp)
EndMacro
Macro Vec4_Abs(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@abs_f(), x)
EndMacro
Macro Vec4_Sign(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@sign_f(), x)
EndMacro
Macro Vec4_Floor(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@Floor_f(), x)
EndMacro
Macro Vec4_Ceil(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@Ceil_f(), x)
EndMacro
Macro Vec4_fract(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@fract_f(), x)
EndMacro
Macro Vec4_roundEven(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@roundEven_f(), x)
EndMacro
Macro Vec4_trunc(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@trunc_f(), x)
EndMacro
Macro Vec4_Round(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@round_f(), x)
EndMacro
Macro Vec4_Mod(res, x, y)
  _math::compute_function2(res, math::#type_vec4, math::@mod_f(), x, y)
EndMacro
Macro Vec4_Mod_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec4, math::@mod_f(), x, scalar)
EndMacro
Macro Vec4_min(res, x, y)
  _math::compute_function2(res, math::#type_vec4, _math::@min2_f(), x, y)
EndMacro
Macro Vec4_min_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec4, _math::@min2_f(), x, scalar)
EndMacro
Macro Vec4_max(res, x, y)
  _math::compute_function2(res, math::#type_vec4, _math::@max2_f(), x, y)
EndMacro
Macro Vec4_max_Scalar(res, x, scalar)
  _math::compute_function2s(res, math::#type_vec4, _math::@max2_f(), x, scalar)
EndMacro
Macro Vec4_clamp(res, x, y, z)
  _math::compute_function3(res, math::#type_vec4, math::@clamp_f(), x, y, z)
EndMacro
Macro Vec4_clamp_Scalar(res, x, min=0, max=1)
  _math::compute_function3s(res, math::#type_vec4, math::@clamp_f(), x, min, max)
EndMacro
Macro Vec4_Repeat(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@repeat_f(), x)
EndMacro
Macro Vec4_mirrorClamp(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@repeat_f(), x)
EndMacro
Macro Vec4_mirrorRepeat(res, x)
  _math::compute_function1(res, math::#type_vec4, math::@repeat_f(), x)
EndMacro
Macro Vec4_vec_Step(res, edge, x)
  _math::vec_Step_Vector(res, math::#type_vec4, edge, x)
EndMacro
Macro Vec4_vec_Step_Scalar(res, edgeScalar, x)
  _math::vec_Step_Vector_Scalar(res, math::#type_vec4, edgeScalar, x)
EndMacro
Macro Vec4_smoothstep(res, edge0, edge1, x)
  _math::vec_smoothstep_vector(res, math::#type_vec4, edge0, edge1, x)
EndMacro
Macro Vec4_smoothstep_Scalar(res, edge0Scalar, edge1Scalar, x)
  _math::vec_smoothstep_vector_Scalar(res, math::#type_vec4, edge0Scalar, edge1Scalar, x)
EndMacro
Macro Vec4_string(x,nbdecimals = 2)
  _math::string(x, math::#type_vec4, nbdecimals)
EndMacro
Macro Vec4_stringBool(x)
  _math::stringBool(x, math::#type_vec4)
EndMacro
Macro Vec4_IsNAN(resBool, x)
  _math::is_Nan(resbool, math::#type_vec4, x)
EndMacro
Macro Vec4_isInf(resBool, x)
  _math::is_Inf(resbool, math::#type_vec4, x)
EndMacro
Macro Vec4_any(bool)
  _math::bool_any(bool,math::#type_vec4)
EndMacro
Macro Vec4_all(bool)
  _math::bool_all(bool,math::#type_vec4)
EndMacro
Macro Vec4_Bool_not(resBool, Bool)
  _math::Bool_not(resBool,math::#type_vec4,bool)
EndMacro
Macro Vec4_Bool_and(resBool, Bool)
  _math::Bool_and(resBool,math::#type_vec4,bool)
EndMacro
Macro Vec4_Bool_or(resBool, Bool)
  _math::Bool_or(resBool,math::#type_vec4,bool)
EndMacro
Macro Vec4_equal(resBool, x, y, epsilon = math::#epsilon)
  _math::equal(resBool,math::#type_vec4,x,y,epsilon)
EndMacro
Macro Vec4_notEqual(resBool, x, y, epsilon = math::#epsilon)
  _math::notEqual(resBool,math::#type_vec4,x,y,epsilon)
EndMacro
Macro Vec4_all_equal( x, y, epsilon = math::#epsilon)
  _math::do_all(_math::@equal(),math::#type_vec4,x,y,epsilon)
EndMacro
Macro Vec4_any_notEqual( x, y, epsilon = math::#epsilon)
  _math::do_any(_math::@notEqual(),math::#type_vec4,x,y,epsilon)
EndMacro
Macro Vec4_lessThan(resBool, x, y)
  _math::lessThan(resBool,math::#type_vec4,x,y)
EndMacro
Macro Vec4_lessThanEqual(resBool, x, y)
  _math::lessThanEqual(resBool,math::#type_vec4,x,y)
EndMacro
Macro Vec4_greaterThan(resBool, x, y)
  _math::greaterThan(resBool,math::#type_vec4,x,y)
EndMacro
Macro Vec4_greaterThanEqual(resBool, x, y)
  _math::greaterThanEqual(resBool,math::#type_vec4,x,y)
EndMacro
Macro Vec4_long_from_float(bool,matvec)
  _math::long_from_float(bool,math::#type_vec4,matvec)
EndMacro
Macro Vec4_float_from_long(matvec, bool)
  _math::float_from_long(matvec,math::#type_vec4, bool)
EndMacro
Macro Vec4_mix_Scalar(res, x, y, A)
  _math::compute_mix_scalar(res, math::#type_vec4, x, y, a)
EndMacro
Macro Vec4_mix(res, x, y, A)
  _math::compute_mix(res, math::#type_vec4, x, y, a)
EndMacro
;}
;-----------------------
;- func_geometric.pbi
;{

Declare Vec3_Cross(*res.vec3, *x.Vec3, *y.vec3)
Declare.f refract_f(i, n, eta)
Macro distance2(a, b)
_math::compute_distance2(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), b)
EndMacro
Macro distance(a, b)
Sqr(_math::compute_distance2(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), b))
EndMacro
Macro faceforward(res, n, i, nref)
_math::compute_faceforward(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), n, i, nref)
EndMacro
Macro reflect(res, i, n)
_math::compute_reflect(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), i, n)
EndMacro
Macro refract(res, I, N, eta)
_math::compute_refract(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), I, N, eta)
EndMacro
Macro vec2_dot(a, b)
  (a\x * b\x + a\y * b\y) 
EndMacro
Macro vec3_dot(a, b)
  (a\x * b\x + a\y * b\y + a\z * b\z) 
EndMacro
Macro vec4_dot(a, b)
  (a\x * b\x + a\y * b\y + a\z * b\z + a\w * b\w) 
EndMacro
Macro vec2_length(a)
Sqr((a\x * a\x + a\y * a\y))
EndMacro
Macro vec3_length(a)
Sqr((a\x * a\x + a\y * a\y + a\z * a\z))
EndMacro
Macro vec4_length(a)
Sqr((a\x * a\x + a\y * a\y + a\z * a\z + a\w * a\w))
EndMacro
Macro vec2_length2(a)
((a\x * a\x + a\y * a\y))
EndMacro
Macro vec3_length2(a)
((a\x * a\x + a\y * a\y + a\z * a\z))
EndMacro
Macro vec4_length2(a)
((a\x * a\x + a\y * a\y + a\z * a\z + a\w * a\w))
EndMacro
Macro vec2_normalize(res,v)
  _math::compute_normalize(res, math::#type_vec2, v)
EndMacro
Macro vec3_normalize(res,v)
  _math::compute_normalize(res, math::#type_vec3, v)
EndMacro
Macro vec4_normalize(res,v)
  _math::compute_normalize(res, math::#type_vec4, v)
EndMacro
Macro Vec2_distance2(a, b)
  _math::compute_distance2(a, math::#type_vec2, b)
EndMacro
Macro Vec2_distance(a, b)
  Sqr(_math::compute_distance2(a, math::#type_vec2, b))
EndMacro
Macro Vec2_faceforward(res, n, i, nref)
  _math::compute_faceforward(res, math::#type_vec2, n, i, nref)
EndMacro
Macro Vec2_reflect(res, i, n)
  _math::compute_reflect(res, math::#type_vec2, i, n)
EndMacro
Macro Vec2_refract(res, I, N, eta)
  _math::compute_refract(res, math::#type_vec2, I, N, eta)
EndMacro
Macro Vec3_distance2(a, b)
  _math::compute_distance2(a, math::#type_vec3, b)
EndMacro
Macro Vec3_distance(a, b)
  Sqr(_math::compute_distance2(a, math::#type_vec3, b))
EndMacro
Macro Vec3_faceforward(res, n, i, nref)
  _math::compute_faceforward(res, math::#type_vec3, n, i, nref)
EndMacro
Macro Vec3_reflect(res, i, n)
  _math::compute_reflect(res, math::#type_vec3, i, n)
EndMacro
Macro Vec3_refract(res, I, N, eta)
  _math::compute_refract(res, math::#type_vec3, I, N, eta)
EndMacro
Macro Vec4_distance2(a, b)
  _math::compute_distance2(a, math::#type_vec4, b)
EndMacro
Macro Vec4_distance(a, b)
  Sqr(_math::compute_distance2(a, math::#type_vec4, b))
EndMacro
Macro Vec4_faceforward(res, n, i, nref)
  _math::compute_faceforward(res, math::#type_vec4, n, i, nref)
EndMacro
Macro Vec4_reflect(res, i, n)
  _math::compute_reflect(res, math::#type_vec4, i, n)
EndMacro
Macro Vec4_refract(res, I, N, eta)
  _math::compute_refract(res, math::#type_vec4, I, N, eta)
EndMacro
;}
;-----------------------
;- matrix.pbi
;{

Enumeration type
  #type_mat2x2 = #type_vecmax ; must be <= 8
  #type_mat3x2 
  #type_mat4x2 
  #type_mat2x3 ; must be <= 12
  #type_mat3x3 
  #type_mat4x3
  #type_mat2x4 ; must be <= 16
  #type_mat3x4 
  #type_mat4x4 
  #type_matMAX
EndEnumeration
CompilerIf #type_mat4x2 > SizeOf(vec2) Or #type_mat4x3 > SizeOf(vec3) Or #type_mat4x4 > SizeOf(vec4)
  CompilerError "TOBIG"
CompilerEndIf
;- Mat2x2
Structure Mat2x2
  _math_::StructureAddType(#type_mat2x2)
  StructureUnion
    column.vec2[2]
    value.vec2[2]
    v.vec2[2]
  EndStructureUnion
EndStructure
Structure Mat2x2L
  _math_::StructureAddType(#type_mat2x2)
  StructureUnion
    columnl.vec2L[2]
    valuel.vec2L[2]
    vl.vec2L[2]
  EndStructureUnion
EndStructure
;- Mat2x3
Structure Mat2x3
  _math_::StructureAddType(#type_mat2x3)
  StructureUnion
    column.vec3[2]
    value.vec3[2]
    v.vec3[2]
  EndStructureUnion
EndStructure
Structure Mat2x3L
  _math_::StructureAddType(#type_mat2x3)
  StructureUnion
    columnl.vec3L[2]
    valuel.vec3L[2]
    vl.vec3L[2]
  EndStructureUnion
EndStructure
;- Mat2x4
Structure Mat2x4
  _math_::StructureAddType(#type_mat2x4)
  StructureUnion
    column.vec4[2]
    value.vec4[2]
    v.vec4[2]
  EndStructureUnion
EndStructure
Structure Mat2x4L
  _math_::StructureAddType(#type_mat2x4)
  StructureUnion
    columnl.vec4L[2]
    valuel.vec4L[2]
    vl.vec4L[2]
  EndStructureUnion
EndStructure
;- Mat3x2
Structure Mat3x2
  _math_::StructureAddType(#type_mat3x2)
  StructureUnion    
    column.vec2[3]
    value.vec2[3]
    v.vec2[3]
  EndStructureUnion
EndStructure
Structure Mat3x2L
  _math_::StructureAddType(#type_mat3x2)
  StructureUnion
    columnl.vec2L[3]
    valuel.vec2L[3]
    vl.vec2L[3]
  EndStructureUnion
EndStructure
;- Mat3x3
Structure Mat3x3
  _math_::StructureAddType(#type_mat3x3)
  StructureUnion
    column.vec3[3]
    value.vec3[3]
    v.vec3[3]
  EndStructureUnion
EndStructure
Structure Mat3x3L
  _math_::StructureAddType(#type_mat3x3)
  StructureUnion
    columnl.vec3L[3]
    valuel.vec3L[3]
    vl.vec3L[3]
  EndStructureUnion
EndStructure
;- Mat3x4
Structure Mat3x4
  _math_::StructureAddType(#type_mat3x4)
  StructureUnion
    column.vec4[3]
    value.vec4[3]
    v.vec4[3]
  EndStructureUnion
EndStructure
Structure Mat3x4L
  _math_::StructureAddType(#type_mat3x4)
  StructureUnion
    columnl.vec4L[3]
    valuel.vec4L[3]
    vl.vec4L[3]
  EndStructureUnion
EndStructure
;- Mat4x2
Structure Mat4x2
  _math_::StructureAddType(#type_mat4x2)
  StructureUnion
    column.vec2[4]
    value.vec2[4]
    v.vec2[4]
  EndStructureUnion
EndStructure
Structure Mat4x2L
  _math_::StructureAddType(#type_mat4x2)
  StructureUnion
    columnl.vec2L[4]
    valuel.vec2L[4]
    vl.vec2L[4]
  EndStructureUnion
EndStructure
;- Mat4x3
Structure Mat4x3
  _math_::StructureAddType(#type_mat4x3)
  StructureUnion
    column.vec3[4]
    value.vec3[4]
    v.vec3[4]
  EndStructureUnion
EndStructure
Structure Mat4x3L
  _math_::StructureAddType(#type_mat4x3)
  StructureUnion
    columnl.vec3L[4]
    valuel.vec3L[4]
    vl.vec3L[4]
  EndStructureUnion
EndStructure
;- Mat4x4
Structure Mat4x4
  _math_::StructureAddType(#type_mat4x4)
  StructureUnion
    column.vec4[4]
    value.vec4[4]
    v.vec4[4]
  EndStructureUnion
EndStructure
Structure Mat4x4L
  _math_::StructureAddType(#type_mat4x4)
  StructureUnion
    columnl.vec4L[4]
    valuel.vec4L[4]
    vl.vec4L[4]
  EndStructureUnion
EndStructure
;}
;-----------------------
;- type_matrix.pbi
;{

Declare Mat2x2_set_float(*res.Mat2x2, x0.f, y0.f, x1.f, y1.f)
Declare Mat2x2_set_vec2(*res.Mat2x2, *v0.vec2, *v1.vec2)
Declare Mat2x2_set(*res.Mat2x2, *m.Mat2x2)
Declare Mat2x2_set_Mat2x3(*res.Mat2x2, *m.Mat2x3)
Declare Mat2x2_set_Mat2x4(*res.Mat2x2, *m.Mat2x4)
Declare Mat2x2_set_Mat3x2(*res.Mat2x2, *m.Mat3x2)
Declare Mat2x2_set_Mat3x3(*res.Mat2x2, *m.Mat3x3)
Declare Mat2x2_set_Mat3x4(*res.Mat2x2, *m.Mat3x4)
Declare Mat2x2_set_Mat4x2(*res.Mat2x2, *m.Mat4x2)
Declare Mat2x2_set_Mat4x3(*res.Mat2x2, *m.Mat4x3)
Declare Mat2x2_set_Mat4x4(*res.Mat2x2, *m.Mat4x4)
Declare Mat2x2_set_Scalar(*res.Mat2x2, s.f)
Declare Mat2x2_add_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
Declare Mat2x2_sub_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
Declare Mat2x2_mul_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
Declare Mat2x2_div_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
Declare Scalar_add_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
Declare Scalar_sub_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
Declare Scalar_mul_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
Declare Scalar_div_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
Declare Mat2x2_add(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_sub(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_mul(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_mul_Mat3x2(*res.Mat3x2, *m1.Mat2x2, *m2.Mat3x2)
Declare Mat2x2_mul_Mat4x2(*res.Mat4x2, *m1.Mat2x2, *m2.Mat4x2)
Declare Mat2x2_div(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
Declare Mat2x2_div_vec2(*res.Mat2x2, *m.Mat2x2, *v.vec2)
Declare vec2_div_Mat2x2(*res.Mat2x2, *v.vec2, *m.Mat2x2 )
Declare Mat2x2_mul_Vec2(*vecres.Vec2, *m.Mat2x2, *v.Vec2)
Declare Vec2_mul_Mat2x2(*vecres.Vec2, *v.Vec2, *m.Mat2x2)
Declare Mat2x3_set_float(*res.Mat2x3, x0.f, y0.f, z0.f, x1.f, y1.f, z1.f)
Declare Mat2x3_set_vec3(*res.Mat2x3, *v0.vec3, *v1.vec3)
Declare Mat2x3_set_Mat2x2(*res.Mat2x3, *m.Mat2x2)
Declare Mat2x3_set(*res.Mat2x3, *m.Mat2x3)
Declare Mat2x3_set_Mat2x4(*res.Mat2x3, *m.Mat2x4)
Declare Mat2x3_set_Mat3x2(*res.Mat2x3, *m.Mat3x2)
Declare Mat2x3_set_Mat3x3(*res.Mat2x3, *m.Mat3x3)
Declare Mat2x3_set_Mat3x4(*res.Mat2x3, *m.Mat3x4)
Declare Mat2x3_set_Mat4x2(*res.Mat2x3, *m.Mat4x2)
Declare Mat2x3_set_Mat4x3(*res.Mat2x3, *m.Mat4x3)
Declare Mat2x3_set_Mat4x4(*res.Mat2x3, *m.Mat4x4)
Declare Mat2x3_set_Scalar(*res.Mat2x3, s.f)
Declare Mat2x3_add_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
Declare Mat2x3_sub_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
Declare Mat2x3_mul_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
Declare Mat2x3_div_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
Declare Scalar_add_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
Declare Scalar_sub_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
Declare Scalar_mul_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
Declare Scalar_div_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
Declare Mat2x3_add(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
Declare Mat2x3_sub(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
Declare Mat2x3_mul_Mat2x2(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x2)
Declare Mat2x3_mul_Mat3x2(*res.Mat3x3, *m1.Mat2x3, *m2.Mat3x2)
Declare Mat2x3_mul_Mat4x2(*res.Mat4x3, *m1.Mat2x3, *m2.Mat4x2)
Declare Mat2x3_mul_Vec2(*vecres.Vec3, *m.Mat2x3, *v.Vec2)
Declare Vec3_mul_Mat2x3(*vecres.Vec2, *v.Vec3, *m.Mat2x3)
Declare Mat2x4_set_float(*res.Mat2x4, x0.f, y0.f, z0.f, w0.f, x1.f, y1.f, z1.f, w1.f)
Declare Mat2x4_set_vec4(*res.Mat2x4, *v0.vec4, *v1.vec4)
Declare Mat2x4_set_Mat2x2(*res.Mat2x4, *m.Mat2x2)
Declare Mat2x4_set_Mat2x3(*res.Mat2x4, *m.Mat2x3)
Declare Mat2x4_set(*res.Mat2x4, *m.Mat2x4)
Declare Mat2x4_set_Mat3x2(*res.Mat2x4, *m.Mat3x2)
Declare Mat2x4_set_Mat3x3(*res.Mat2x4, *m.Mat3x3)
Declare Mat2x4_set_Mat3x4(*res.Mat2x4, *m.Mat3x4)
Declare Mat2x4_set_Mat4x2(*res.Mat2x4, *m.Mat4x2)
Declare Mat2x4_set_Mat4x3(*res.Mat2x4, *m.Mat4x3)
Declare Mat2x4_set_Mat4x4(*res.Mat2x4, *m.Mat4x4)
Declare Mat2x4_set_Scalar(*res.Mat2x4, s.f)
Declare Mat2x4_add_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
Declare Mat2x4_sub_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
Declare Mat2x4_mul_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
Declare Mat2x4_div_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
Declare Scalar_add_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
Declare Scalar_sub_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
Declare Scalar_mul_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
Declare Scalar_div_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
Declare Mat2x4_add(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
Declare Mat2x4_sub(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
Declare Mat2x4_mul_Mat2x2(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x2)
Declare Mat2x4_mul_Mat3x2(*res.Mat3x4, *m1.Mat2x4, *m2.Mat3x2)
Declare Mat2x4_mul_Mat4x2(*res.Mat4x4, *m1.Mat2x4, *m2.Mat4x2)
Declare Mat2x4_mul_Vec2(*vecres.Vec4, *m.Mat2x4, *v.Vec2)
Declare Vec4_mul_Mat2x4(*vecres.Vec2, *v.Vec4, *m.Mat2x4)
Declare Mat3x2_set_float(*res.Mat3x2, x0.f, y0.f, x1.f, y1.f, x2.f, y2.f)
Declare Mat3x2_set_vec2(*res.Mat3x2, *v0.vec2, *v1.vec2, *v2.vec2)
Declare Mat3x2_set_Mat2x2(*res.Mat3x2, *m.Mat2x2)
Declare Mat3x2_set_Mat2x3(*res.Mat3x2, *m.Mat2x3)
Declare Mat3x2_set_Mat2x4(*res.Mat3x2, *m.Mat2x4)
Declare Mat3x2_set(*res.Mat3x2, *m.Mat3x2)
Declare Mat3x2_set_Mat3x3(*res.Mat3x2, *m.Mat3x3)
Declare Mat3x2_set_Mat3x4(*res.Mat3x2, *m.Mat3x4)
Declare Mat3x2_set_Mat4x2(*res.Mat3x2, *m.Mat4x2)
Declare Mat3x2_set_Mat4x3(*res.Mat3x2, *m.Mat4x3)
Declare Mat3x2_set_Mat4x4(*res.Mat3x2, *m.Mat4x4)
Declare Mat3x2_set_Scalar(*res.Mat3x2, s.f)
Declare Mat3x2_add_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
Declare Mat3x2_sub_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
Declare Mat3x2_mul_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
Declare Mat3x2_div_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
Declare Scalar_add_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
Declare Scalar_sub_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
Declare Scalar_mul_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
Declare Scalar_div_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
Declare Mat3x2_add(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
Declare Mat3x2_sub(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
Declare Mat3x2_mul_Mat2x3(*res.Mat2x2, *m1.Mat3x2, *m2.Mat2x3)
Declare Mat3x2_mul_Mat3x3(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x3)
Declare Mat3x2_mul_Mat4x3(*res.Mat4x2, *m1.Mat3x2, *m2.Mat4x3)
Declare Mat3x2_mul_Vec3(*vecres.Vec2, *m.Mat3x2, *v.Vec3)
Declare Vec2_mul_Mat3x2(*vecres.Vec3, *v.Vec2, *m.Mat3x2)
Declare Mat3x3_set_float(*res.Mat3x3, x0.f, y0.f, z0.f, x1.f, y1.f, z1.f, x2.f, y2.f, z2.f)
Declare Mat3x3_set_vec3(*res.Mat3x3, *v0.vec3, *v1.vec3, *v2.vec3)
Declare Mat3x3_set_Mat2x2(*res.Mat3x3, *m.Mat2x2)
Declare Mat3x3_set_Mat2x3(*res.Mat3x3, *m.Mat2x3)
Declare Mat3x3_set_Mat2x4(*res.Mat3x3, *m.Mat2x4)
Declare Mat3x3_set_Mat3x2(*res.Mat3x3, *m.Mat3x2)
Declare Mat3x3_set(*res.Mat3x3, *m.Mat3x3)
Declare Mat3x3_set_Mat3x4(*res.Mat3x3, *m.Mat3x4)
Declare Mat3x3_set_Mat4x2(*res.Mat3x3, *m.Mat4x2)
Declare Mat3x3_set_Mat4x3(*res.Mat3x3, *m.Mat4x3)
Declare Mat3x3_set_Mat4x4(*res.Mat3x3, *m.Mat4x4)
Declare Mat3x3_set_Scalar(*res.Mat3x3, s.f)
Declare Mat3x3_add_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
Declare Mat3x3_sub_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
Declare Mat3x3_mul_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
Declare Mat3x3_div_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
Declare Scalar_add_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
Declare Scalar_sub_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
Declare Scalar_mul_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
Declare Scalar_div_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
Declare Mat3x3_add(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_sub(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_mul_Mat2x3(*res.Mat2x3, *m1.Mat3x3, *m2.Mat2x3)
Declare Mat3x3_mul(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_mul_Mat4x3(*res.Mat4x3, *m1.Mat3x3, *m2.Mat4x3)
Declare Mat3x3_div(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
Declare Mat3x3_div_vec3(*res.Mat3x3, *m.Mat3x3, *v.vec3)
Declare vec3_div_Mat3x3(*res.Mat3x3, *v.vec3, *m.Mat3x3 )
Declare Mat3x3_mul_Vec3(*vecres.Vec3, *m.Mat3x3, *v.Vec3)
Declare Vec3_mul_Mat3x3(*vecres.Vec3, *v.Vec3, *m.Mat3x3)
Declare Mat3x4_set_float(*res.Mat3x4, x0.f, y0.f, z0.f, w0.f, x1.f, y1.f, z1.f, w1.f, x2.f, y2.f, z2.f, w2.f)
Declare Mat3x4_set_vec4(*res.Mat3x4, *v0.vec4, *v1.vec4, *v2.vec4)
Declare Mat3x4_set_Mat2x2(*res.Mat3x4, *m.Mat2x2)
Declare Mat3x4_set_Mat2x3(*res.Mat3x4, *m.Mat2x3)
Declare Mat3x4_set_Mat2x4(*res.Mat3x4, *m.Mat2x4)
Declare Mat3x4_set_Mat3x2(*res.Mat3x4, *m.Mat3x2)
Declare Mat3x4_set_Mat3x3(*res.Mat3x4, *m.Mat3x3)
Declare Mat3x4_set(*res.Mat3x4, *m.Mat3x4)
Declare Mat3x4_set_Mat4x2(*res.Mat3x4, *m.Mat4x2)
Declare Mat3x4_set_Mat4x3(*res.Mat3x4, *m.Mat4x3)
Declare Mat3x4_set_Mat4x4(*res.Mat3x4, *m.Mat4x4)
Declare Mat3x4_set_Scalar(*res.Mat3x4, s.f)
Declare Mat3x4_add_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
Declare Mat3x4_sub_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
Declare Mat3x4_mul_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
Declare Mat3x4_div_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
Declare Scalar_add_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
Declare Scalar_sub_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
Declare Scalar_mul_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
Declare Scalar_div_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
Declare Mat3x4_add(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
Declare Mat3x4_sub(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
Declare Mat3x4_mul_Mat2x3(*res.Mat2x4, *m1.Mat3x4, *m2.Mat2x3)
Declare Mat3x4_mul_Mat3x3(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x3)
Declare Mat3x4_mul_Mat4x3(*res.Mat4x4, *m1.Mat3x4, *m2.Mat4x3)
Declare Mat3x4_mul_Vec3(*vecres.Vec4, *m.Mat3x4, *v.Vec3)
Declare Vec4_mul_Mat3x4(*vecres.Vec3, *v.Vec4, *m.Mat3x4)
Declare Mat4x2_set_float(*res.Mat4x2, x0.f, y0.f, x1.f, y1.f, x2.f, y2.f, x3.f, y3.f)
Declare Mat4x2_set_vec2(*res.Mat4x2, *v0.vec2, *v1.vec2, *v2.vec2, *v3.vec2)
Declare Mat4x2_set_Mat2x2(*res.Mat4x2, *m.Mat2x2)
Declare Mat4x2_set_Mat2x3(*res.Mat4x2, *m.Mat2x3)
Declare Mat4x2_set_Mat2x4(*res.Mat4x2, *m.Mat2x4)
Declare Mat4x2_set_Mat3x2(*res.Mat4x2, *m.Mat3x2)
Declare Mat4x2_set_Mat3x3(*res.Mat4x2, *m.Mat3x3)
Declare Mat4x2_set_Mat3x4(*res.Mat4x2, *m.Mat3x4)
Declare Mat4x2_set(*res.Mat4x2, *m.Mat4x2)
Declare Mat4x2_set_Mat4x3(*res.Mat4x2, *m.Mat4x3)
Declare Mat4x2_set_Mat4x4(*res.Mat4x2, *m.Mat4x4)
Declare Mat4x2_set_Scalar(*res.Mat4x2, s.f)
Declare Mat4x2_add_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
Declare Mat4x2_sub_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
Declare Mat4x2_mul_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
Declare Mat4x2_div_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
Declare Scalar_add_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
Declare Scalar_sub_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
Declare Scalar_mul_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
Declare Scalar_div_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
Declare Mat4x2_add(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
Declare Mat4x2_sub(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
Declare Mat4x2_mul_Mat2x4(*res.Mat2x2, *m1.Mat4x2, *m2.Mat2x4)
Declare Mat4x2_mul_Mat3x4(*res.Mat3x2, *m1.Mat4x2, *m2.Mat3x4)
Declare Mat4x2_mul_Mat4x4(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x4)
Declare Mat4x2_mul_Vec4(*vecres.Vec2, *m.Mat4x2, *v.Vec4)
Declare Vec2_mul_Mat4x2(*vecres.Vec4, *v.Vec2, *m.Mat4x2)
Declare Mat4x3_set_float(*res.Mat4x3, x0.f, y0.f, z0.f, x1.f, y1.f, z1.f, x2.f, y2.f, z2.f, x3.f, y3.f, z3.f)
Declare Mat4x3_set_vec3(*res.Mat4x3, *v0.vec3, *v1.vec3, *v2.vec3, *v3.vec3)
Declare Mat4x3_set_Mat2x2(*res.Mat4x3, *m.Mat2x2)
Declare Mat4x3_set_Mat2x3(*res.Mat4x3, *m.Mat2x3)
Declare Mat4x3_set_Mat2x4(*res.Mat4x3, *m.Mat2x4)
Declare Mat4x3_set_Mat3x2(*res.Mat4x3, *m.Mat3x2)
Declare Mat4x3_set_Mat3x3(*res.Mat4x3, *m.Mat3x3)
Declare Mat4x3_set_Mat3x4(*res.Mat4x3, *m.Mat3x4)
Declare Mat4x3_set_Mat4x2(*res.Mat4x3, *m.Mat4x2)
Declare Mat4x3_set(*res.Mat4x3, *m.Mat4x3)
Declare Mat4x3_set_Mat4x4(*res.Mat4x3, *m.Mat4x4)
Declare Mat4x3_set_Scalar(*res.Mat4x3, s.f)
Declare Mat4x3_add_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
Declare Mat4x3_sub_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
Declare Mat4x3_mul_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
Declare Mat4x3_div_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
Declare Scalar_add_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
Declare Scalar_sub_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
Declare Scalar_mul_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
Declare Scalar_div_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
Declare Mat4x3_add(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
Declare Mat4x3_sub(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
Declare Mat4x3_mul_Mat2x4(*res.Mat2x3, *m1.Mat4x3, *m2.Mat2x4)
Declare Mat4x3_mul_Mat3x4(*res.Mat3x3, *m1.Mat4x3, *m2.Mat3x4)
Declare Mat4x3_mul_Mat4x4(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x4)
Declare Mat4x3_mul_Vec4(*vecres.Vec3, *m.Mat4x3, *v.Vec4)
Declare Vec3_mul_Mat4x3(*vecres.Vec4, *v.Vec3, *m.Mat4x3)
Declare Mat4x4_set_float(*res.Mat4x4, x0.f, y0.f, z0.f, w0.f, x1.f, y1.f, z1.f, w1.f, x2.f, y2.f, z2.f, w2.f, x3.f, y3.f, z3.f, w3.f)
Declare Mat4x4_set_vec4(*res.Mat4x4, *v0.vec4, *v1.vec4, *v2.vec4, *v3.vec4)
Declare Mat4x4_set_Mat2x2(*res.Mat4x4, *m.Mat2x2)
Declare Mat4x4_set_Mat2x3(*res.Mat4x4, *m.Mat2x3)
Declare Mat4x4_set_Mat2x4(*res.Mat4x4, *m.Mat2x4)
Declare Mat4x4_set_Mat3x2(*res.Mat4x4, *m.Mat3x2)
Declare Mat4x4_set_Mat3x3(*res.Mat4x4, *m.Mat3x3)
Declare Mat4x4_set_Mat3x4(*res.Mat4x4, *m.Mat3x4)
Declare Mat4x4_set_Mat4x2(*res.Mat4x4, *m.Mat4x2)
Declare Mat4x4_set_Mat4x3(*res.Mat4x4, *m.Mat4x3)
Declare Mat4x4_set(*res.Mat4x4, *m.Mat4x4)
Declare Mat4x4_set_Scalar(*res.Mat4x4, s.f)
Declare Mat4x4_add_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
Declare Mat4x4_sub_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
Declare Mat4x4_mul_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
Declare Mat4x4_div_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
Declare Scalar_add_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
Declare Scalar_sub_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
Declare Scalar_mul_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
Declare Scalar_div_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
Declare Mat4x4_add(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_sub(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_mul_Mat2x4(*res.Mat2x4, *m1.Mat4x4, *m2.Mat2x4)
Declare Mat4x4_mul_Mat3x4(*res.Mat3x4, *m1.Mat4x4, *m2.Mat3x4)
Declare Mat4x4_mul(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_div(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
Declare Mat4x4_div_vec4(*res.Mat4x4, *m.Mat4x4, *v.vec4)
Declare vec4_div_Mat4x4(*res.Mat4x4, *v.vec4, *m.Mat4x4 )
Declare Mat4x4_mul_Vec4(*vecres.Vec4, *m.Mat4x4, *v.Vec4)
Declare Vec4_mul_Mat4x4(*vecres.Vec4, *v.Vec4, *m.Mat4x4)
;}
;-----------------------
;- func_matrix.pbi
;{

Declare Mat2x2_inverse(*res.Mat2x2, *m.Mat2x2)
Declare Mat3x3_inverse(*res.Mat3x3, *m.Mat3x3)
Declare Mat4x4_inverse(*res.mat4x4, *m.Mat4x4)
Declare mat2x2_transpose(*res.mat2x2, *m.mat2x2)
Declare mat2x3_transpose(*res.mat2x3, *m.mat3x2)
Declare mat2x4_transpose(*res.mat2x4, *m.mat4x2)
Declare mat3x2_transpose(*res.mat3x2, *m.mat2x3)
Declare mat3x3_transpose(*res.mat3x3, *m.mat3x3)
Declare mat3x4_transpose(*res.mat3x4, *m.mat4x3)
Declare mat4x2_transpose(*res.mat4x2, *m.mat2x4)
Declare mat4x3_transpose(*res.mat4x3, *m.mat3x4)
Declare mat4x4_transpose(*res.mat4x4, *m.mat4x4)
Declare.f mat2x2_determinant(*m.mat2x2)
Declare.f mat3x3_determinant(*m.mat3x3)
Declare.f mat4x4_determinant(*m.mat4x4)
Macro matrixCompMult(res, x,y)
_math::compute_matrixCompMult(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), x,y)
EndMacro
Macro outerProduct(res, v1, v2)
_math::compute_outerProduct(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), v1, v2)
EndMacro
;}
;-----------------------
;- func_trigonometric.pbi
;{

Declare.f radians_f(x.f)
Declare.f degrees_f(x.f)
Declare.f sin_f(x.f)
Declare.f Cos_f(x.f)
Declare.f tan_f(x.f)
Declare.f asin_f(x.f)
Declare.f acos_f(x.f)
Declare.f ATan2_f(y.f, x.f)
Declare.f SinH_f(x.f)
Declare.f CosH_f(x.f)
Declare.f TanH_f(x.f)
Declare.f ASinH_f(x.f)
Declare.f acosh_f(x.f)
Declare.f ATanH_f(x.f)
Macro radians(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@radians_f(), v)
EndMacro
Macro degrees(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@degrees_f(), v)
EndMacro
Macro Sin(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sin_f(), v)
EndMacro
Macro Cos(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@Cos_f(), v)
EndMacro
Macro Tan(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@tan_f(), v)
EndMacro
Macro ASin(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@asin_f(), v)
EndMacro
Macro ACos(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acos_f(), v)
EndMacro
Macro ATan(res, v, u)
_math::compute_function2(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@atan_f(), v, u)
EndMacro
Macro SinH(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@SinH_f(), v)
EndMacro
Macro CosH(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@CosH_f(), v)
EndMacro
Macro TanH(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@TanH_f(), v)
EndMacro
Macro ASinH(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@ASinH_f(), v)
EndMacro
Macro ACosH(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acosh_f(), v)
EndMacro
Macro ATanH(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@ATanH_f(), v)
EndMacro
Macro Vec2_radians(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@radians_f(), v)
EndMacro
Macro Vec2_degrees(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@degrees_f(), v)
EndMacro
Macro Vec2_Sin(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@sin_f(), v)
EndMacro
Macro Vec2_Cos(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@Cos_f(), v)
EndMacro
Macro Vec2_Tan(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@tan_f(), v)
EndMacro
Macro Vec2_ASin(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@asin_f(), v)
EndMacro
Macro Vec2_ACos(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@acos_f(), v)
EndMacro
Macro Vec2_ATan(res, v, u)
  _math::compute_function2(res, math::#type_vec2, math::@atan_f(), v, u)
EndMacro
Macro Vec2_SinH(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@SinH_f(), v)
EndMacro
Macro Vec2_CosH(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@CosH_f(), v)
EndMacro
Macro Vec2_TanH(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@TanH_f(), v)
EndMacro
Macro Vec2_ASinH(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@ASinH_f(), v)
EndMacro
Macro Vec2_ACosH(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@acosh_f(), v)
EndMacro
Macro Vec2_ATanH(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@ATanH_f(), v)
EndMacro
Macro Vec3_radians(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@radians_f(), v)
EndMacro
Macro Vec3_degrees(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@degrees_f(), v)
EndMacro
Macro Vec3_Sin(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@sin_f(), v)
EndMacro
Macro Vec3_Cos(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@Cos_f(), v)
EndMacro
Macro Vec3_Tan(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@tan_f(), v)
EndMacro
Macro Vec3_ASin(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@asin_f(), v)
EndMacro
Macro Vec3_ACos(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@acos_f(), v)
EndMacro
Macro Vec3_ATan(res, v, u)
  _math::compute_function2(res, math::#type_vec3, math::@atan_f(), v, u)
EndMacro
Macro Vec3_SinH(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@SinH_f(), v)
EndMacro
Macro Vec3_CosH(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@CosH_f(), v)
EndMacro
Macro Vec3_TanH(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@TanH_f(), v)
EndMacro
Macro Vec3_ASinH(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@ASinH_f(), v)
EndMacro
Macro Vec3_ACosH(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@acosh_f(), v)
EndMacro
Macro Vec3_ATanH(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@ATanH_f(), v)
EndMacro
Macro Vec4_radians(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@radians_f(), v)
EndMacro
Macro Vec4_degrees(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@degrees_f(), v)
EndMacro
Macro Vec4_Sin(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@sin_f(), v)
EndMacro
Macro Vec4_Cos(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@Cos_f(), v)
EndMacro
Macro Vec4_Tan(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@tan_f(), v)
EndMacro
Macro Vec4_ASin(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@asin_f(), v)
EndMacro
Macro Vec4_ACos(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@acos_f(), v)
EndMacro
Macro Vec4_ATan(res, v, u)
  _math::compute_function2(res, math::#type_vec4, math::@atan_f(), v, u)
EndMacro
Macro Vec4_SinH(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@SinH_f(), v)
EndMacro
Macro Vec4_CosH(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@CosH_f(), v)
EndMacro
Macro Vec4_TanH(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@TanH_f(), v)
EndMacro
Macro Vec4_ASinH(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@ASinH_f(), v)
EndMacro
Macro Vec4_ACosH(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@acosh_f(), v)
EndMacro
Macro Vec4_ATanH(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@ATanH_f(), v)
EndMacro
;}
;-----------------------
;- matrix_clip_space.pbi
;{

Declare ortho2(*res.mat4x4, left.f, right.f, bottom.f, top.f)
Declare orthoLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare orthoRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare ortho(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
Declare frustumLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustumRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare frustum(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
Declare perspectiveRH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveRH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveLH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveLH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveNO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
Declare perspectiveFovRH_ZO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
Declare perspectiveFovRH_NO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
Declare perspectiveFovLH_ZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovLH_NO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovNO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovLH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFovRH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare perspectiveFov(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
Declare infinitePerspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
Declare infinitePerspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
Declare infinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f)
Declare tweakedInfinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, ep.f=#epsilon)
;}
;-----------------------
;- matrix_projection.pbi
;{

Declare projectZO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare projectNO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare project(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare unProjectZO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare unProjectNO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare unProject(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
Declare pickMatrix(*res.mat4x4, *center.vec2, *delta.vec2, *viewport.vec4)
;}
;-----------------------
;- matrix_transform.pbi
;{

Declare translate(*res.mat4x4, *m.mat4x4, *v.vec3)
Declare translate_float(*res.mat4x4, *m.mat4x4, x.f,y.f,z.f)
Declare rotate(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
Declare rotate_float(*res.mat4x4, *m.mat4x4, angle.f, x.f,y.f,z.f)
Declare rotate_slow(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
Declare rotate_slow_float(*res.mat4x4, *m.mat4x4, angle.f, x.f,y.f,z.f)
Declare scale(*res.mat4x4, *m.mat4x4, *v.vec3)
Declare scale_float(*res.mat4x4, *m.mat4x4, x.f,y.f,z.f)
Declare scale_slow(*res.mat4x4, *m.mat4x4, *v.vec3)
Declare scale_slow_float(*res.mat4x4, *m.mat4x4, x.f,y.f,z.f)
Declare lookAtRH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
Declare lookAtLH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
Declare lookAt(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
;}
;-----------------------
;- quaternion.pbi
;{

#type_quat = 1
Structure Quat
  _math_::StructureAddType(#type_quat)
  StructureUnion
    w.f
    f.f[0]
  EndStructureUnion
  StructureUnion
    x.f  
  EndStructureUnion
  StructureUnion
    y.f  
  EndStructureUnion
  StructureUnion
    z.f    
  EndStructureUnion
EndStructure
Structure QuatL
  _math_::StructureAddType(#type_quat)
  StructureUnion
    w.l
    l.l[0]
  EndStructureUnion
  StructureUnion
    x.l  
  EndStructureUnion
  StructureUnion
    y.l  
  EndStructureUnion
  StructureUnion
    z.l    
  EndStructureUnion
EndStructure
;}
;-----------------------
;- type_quat.pbi
;{

Macro quat_const(label, wf,xf, yf, zf)
  DataSection
    label:
    Data.f wf, xf, yf, zf
  EndDataSection
EndMacro
Declare quat_set_float(*res.quat, w.f=1.0, x.f=0.0, y.f=0.0, z.f=0.0)
Declare quat_set_Scalar(*res.quat, s.f)
Declare quat_set(*res.quat, *q.quat)
Declare quat_set_f_vec3(*res.quat,s.f,*v.vec3)
Declare Quat_set_vec3_vec3(*res.quat, *u.vec3, *v.vec3)
Declare quat_set_eulerAngle(*res.quat, *eulerAngle.vec3)
Declare quat_set_mat3x3(*res.quat, *m.mat3x3)
Declare quat_set_mat4x4(*res.quat, *m.mat4x4)
Declare mat3x3_set_quat(*res.mat3x3, *q.quat)
Declare mat4x4_set_quat(*res.mat4x4, *q.quat)
Declare quat_mul(*res.quat, *q.quat, *p.quat)
Declare quat_mul_vec3(*res.vec3, *q.quat, *v.vec3)
Declare vec3_mul_quat(*res.vec3, *v.vec3, *q.quat)
Declare quat_mul_vec4(*res.vec4, *q.quat, *v.vec4)
Declare vec4_mul_quat(*res.vec4, *v.vec4, *q.quat)
Declare quat_add_Scalar(*res.quat, *q.quat, s.f)
Declare quat_sub_Scalar(*res.quat, *q.quat, s.f)
Declare quat_mul_Scalar(*res.quat, *q.quat, s.f)
Declare quat_div_Scalar(*res.quat, *q.quat, s.f)
Declare Scalar_add_quat(*res.quat, s.f, *q.quat)
Declare Scalar_sub_quat(*res.quat, s.f, *q.quat)
Declare Scalar_mul_quat(*res.quat, s.f, *q.quat)
Declare Scalar_div_quat(*res.quat, s.f, *q.quat)
Declare quat_add(*res.quat, *q.quat, *p.quat)
Declare quat_sub(*res.quat, *q.quat, *p.quat)
Declare quat_isEqual(*q.quat, *p.quat)
;}
;-----------------------
;- quaternion_common.pbi
;{

Declare quat_mix(*res.quat, *x.quat, *y.quat, a.f)
Declare quat_lerp(*res.quat, *x.quat, *y.quat, a.f)
Declare quat_slerp(*res.quat, *x.quat, *y.quat, a.f, k.f = 0)
Declare quat_inverse(*res.quat, *q.quat)
Declare quat_conjugate(*res.quat, *q.quat)
;}
;-----------------------
;- quaternion_geometric.pbi
;{

Declare quat_normalize(*res.quat, *q.quat)
Declare quat_cross(*res.quat, *q1.quat, *q2.quat)
;}
;-----------------------
;- quaternion_exponential.pbi
;{

Declare quat_exp(*res.quat, *q.quat)
Declare quat_pow(*res.quat, *x.quat, y.f)
Declare quat_Log(*res.quat, *q.quat)
Declare quat_sqrt(*res.quat, *q.quat)
;}
;-----------------------
;- quaternion_transform.pbi
;{

Declare quat_rotate(*res.quat, *q.quat, angle.f, *v.vec3)
;}
;-----------------------
;- quaternion_trigonometric.pbi
;{

Declare.f angle(*x.quat)
Declare axis(*res.vec3, *x.quat)
Declare angleAxis(*res.quat, angle.f, *v.vec3)
;}
;-----------------------
;- scalar_reciprocal.pbi
;{

Declare.f sec_f(angle.f)
Declare.f csc_f(angle.f)
Declare.f cot_f(angle.f)
Declare.f asec_f(x.f)
Declare.f acsc_f(x.f)
Declare.f acot_f(x.f)
Declare.f sech_f(angle.f)
Declare.f csch_f(angle.f)
Declare.f coth_f(angle.f)
Declare.f asech_f(x.f)
Declare.f acsch_f(x.f)
Declare.f acoth_f(x.f)
Macro sec(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sec_f(), v)
EndMacro
Macro csc(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@csc_f(), v)
EndMacro
Macro cot(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@cot_f(), v)
EndMacro
Macro asec(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@asec_f(), v)
EndMacro
Macro acsc(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acsc_f(), v)
EndMacro
Macro acot(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acot_f(), v)
EndMacro
Macro sech(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@sech_f(), v)
EndMacro
Macro csch(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@csch_f(), v)
EndMacro
Macro coth(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@coth_f(), v)
EndMacro
Macro asech(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@asech_f(), v)
EndMacro
Macro acsch(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acsch_f(), v)
EndMacro
Macro acoth(res, v)
_math::compute_function1(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), math::@acoth_f(), v)
EndMacro
Macro Vec2_sec(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@sec_f(), v)
EndMacro
Macro Vec2_csc(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@csc_f(), v)
EndMacro
Macro Vec2_cot(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@cot_f(), v)
EndMacro
Macro Vec2_asec(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@asec_f(), v)
EndMacro
Macro Vec2_acsc(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@acsc_f(), v)
EndMacro
Macro Vec2_acot(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@acot_f(), v)
EndMacro
Macro Vec2_sech(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@sech_f(), v)
EndMacro
Macro Vec2_csch(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@csch_f(), v)
EndMacro
Macro Vec2_coth(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@coth_f(), v)
EndMacro
Macro Vec2_asech(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@asech_f(), v)
EndMacro
Macro Vec2_acsch(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@acsch_f(), v)
EndMacro
Macro Vec2_acoth(res, v)
  _math::compute_function1(res, math::#type_vec2, math::@acoth_f(), v)
EndMacro
Macro Vec3_sec(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@sec_f(), v)
EndMacro
Macro Vec3_csc(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@csc_f(), v)
EndMacro
Macro Vec3_cot(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@cot_f(), v)
EndMacro
Macro Vec3_asec(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@asec_f(), v)
EndMacro
Macro Vec3_acsc(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@acsc_f(), v)
EndMacro
Macro Vec3_acot(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@acot_f(), v)
EndMacro
Macro Vec3_sech(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@sech_f(), v)
EndMacro
Macro Vec3_csch(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@csch_f(), v)
EndMacro
Macro Vec3_coth(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@coth_f(), v)
EndMacro
Macro Vec3_asech(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@asech_f(), v)
EndMacro
Macro Vec3_acsch(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@acsch_f(), v)
EndMacro
Macro Vec3_acoth(res, v)
  _math::compute_function1(res, math::#type_vec3, math::@acoth_f(), v)
EndMacro
Macro Vec4_sec(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@sec_f(), v)
EndMacro
Macro Vec4_csc(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@csc_f(), v)
EndMacro
Macro Vec4_cot(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@cot_f(), v)
EndMacro
Macro Vec4_asec(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@asec_f(), v)
EndMacro
Macro Vec4_acsc(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@acsc_f(), v)
EndMacro
Macro Vec4_acot(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@acot_f(), v)
EndMacro
Macro Vec4_sech(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@sech_f(), v)
EndMacro
Macro Vec4_csch(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@csch_f(), v)
EndMacro
Macro Vec4_coth(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@coth_f(), v)
EndMacro
Macro Vec4_asech(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@asech_f(), v)
EndMacro
Macro Vec4_acsch(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@acsch_f(), v)
EndMacro
Macro Vec4_acoth(res, v)
  _math::compute_function1(res, math::#type_vec4, math::@acoth_f(), v)
EndMacro
;}
;-----------------------
;- quatemion.pbi
;{

Declare quat_eulerAngles(*res.vec3, *x.quat)
Declare quat_LookAt(*res.quat, *direction.vec3, *up.vec3)
Declare quat_LookAtRH(*res.quat, *direction.vec3, *up.vec3)
Declare quat_LookAtLH(*res.quat, *direction.vec3, *up.vec3)
Declare.f quat_Roll(*q.math::quat)
Declare.f quat_Pitch(*q.math::quat)
Declare.f quat_Yaw(*q.math::quat)
;}
;-----------------------
;- euler_angles.pbi
;{

Declare eulerAngleX(*res.mat4x4, angleX.f)
Declare eulerAngleY(*res.mat4x4, angleY.f)
Declare eulerAngleZ(*res.mat4x4, angleZ.f)
Declare derivedEulerAngleX(*res.mat4x4, angleX.f, angularVelocityX.f)
Declare derivedEulerAngleY(*res.mat4x4, angleY.f, angularVelocityY.f)
Declare derivedEulerAngleZ(*res.mat4x4, angleZ.f, angularVelocityZ.f)
Declare eulerAngleXY(*res.mat4x4, angleX.f, angleY.f)
Declare eulerAngleYX(*res.mat4x4, angleY.f, angleX.f)
Declare eulerAngleXZ(*res.mat4x4, angleX.f, angleZ.f)
Declare eulerAngleZX(*res.mat4x4, angleZ.f, angleX.f)
Declare eulerAngleYZ(*res.mat4x4, angleY.f, angleZ.f)
Declare eulerAngleZY(*res.mat4x4, angleZ.f, angleY.f)
Declare eulerAngleXYZ(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleYXZ(*res.mat4x4, yaw.f, pitch.f, roll.f)
Declare eulerAngleXZX(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleXYX(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleYXY(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleYZY(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleZYZ(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleZXZ(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleXZY(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleYZX(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleZYX(*res.mat4x4, t1.f, t2.f, t3.f)
Declare eulerAngleZXY(*res.mat4x4, t1.f, t2.f, t3.f)
Declare yawPitchRoll(*res.mat4x4, yaw.f, pitch.f, roll.f)
Declare orientate2(*res.mat2x2, angle.f)
Declare orientate3_float(*res.mat3x3, angle.f)
Declare orientate3_vec3(*res.mat3x3, *angles.vec3)
Declare orientate4(*res.mat4x4, *angles.vec3)
Declare extractEulerAngleXYZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleYXZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleXZX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleXYX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleYXY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleYZY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleZYZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleZXZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleXZY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleYZX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleZYX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
Declare extractEulerAngleZXY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
;}
;-----------------------
;- dispatcher.pbi
;{

Macro add(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_add(res, m1, m2)
    CompilerCase math::#type_vec2
      math::vec2_add(res, m1, m2)
    CompilerCase math::#type_vec3
      math::vec3_add(res, m1, m2)
    CompilerCase math::#type_vec4
      math::vec4_add(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_add(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_add(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_add(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_add(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_add(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_add(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_add(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_add(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_add(res, m1, m2)
    CompilerDefault
      CompilerError "[add] unsupported type"
  CompilerEndSelect
EndMacro
Macro mul(res, m1, m2)
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3))) <<8 +((((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3)))<<16)
CompilerCase ((math::#type_quat) +(math::#type_quat) <<8 +(math::#type_quat) <<16);quat
      math::quat_mul(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_quat) <<8 +(math::#type_vec3) <<16)
      math::quat_mul_vec3(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_quat) <<16)
      math::vec3_mul_quat(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_quat) <<8 +(math::#type_vec3) <<16)
      math::quat_mul_vec4(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_quat) <<16)
      math::vec4_mul_quat(res, m1, m2)
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8 +(math::#type_vec2) <<16); vec vec
      math::vec2_mul(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_vec3) <<16)
      math::vec3_mul(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_vec4) <<16)
      math::vec4_mul(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Mat2x2) <<8 +(math::#type_Vec2) <<16); mat vec
      math::Mat2x2_mul_Vec2(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Mat2x3) <<8 +(math::#type_Vec2) <<16)
      math::Mat2x3_mul_Vec2(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Mat2x4) <<8 +(math::#type_Vec2) <<16)
      math::Mat2x4_mul_Vec2(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Mat3x2) <<8 +(math::#type_Vec3) <<16)
      math::Mat3x2_mul_Vec3(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Mat3x3) <<8 +(math::#type_Vec3) <<16)
      math::Mat3x3_mul_Vec3(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Mat3x4) <<8 +(math::#type_Vec3) <<16)
      math::Mat3x4_mul_Vec3(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Mat4x2) <<8 +(math::#type_Vec4) <<16)
      math::Mat4x2_mul_Vec4(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Mat4x3) <<8 +(math::#type_Vec4) <<16)
      math::Mat4x3_mul_Vec4(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Mat4x4) <<8 +(math::#type_Vec4) <<16)
      math::Mat4x4_mul_Vec4(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Vec2) <<8 +(math::#type_Mat2x2) <<16); vec mat
      math::Vec2_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Vec3) <<8 +(math::#type_Mat2x3) <<16)
      math::Vec3_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Vec2) +(math::#type_Vec4) <<8 +(math::#type_Mat2x4) <<16)
      math::Vec4_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Vec2) <<8 +(math::#type_Mat3x2) <<16)
      math::Vec2_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Vec3) <<8 +(math::#type_Mat3x3) <<16)
      math::Vec3_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Vec3) +(math::#type_Vec4) <<8 +(math::#type_Mat3x4) <<16)
      math::Vec4_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Vec2) <<8 +(math::#type_Mat4x2) <<16)
      math::Vec2_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Vec3) <<8 +(math::#type_Mat4x3) <<16)
      math::Vec3_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Vec4) +(math::#type_Vec4) <<8 +(math::#type_Mat4x4) <<16)
      math::Vec4_mul_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat2x2) <<16);mat mat
      math::Mat2x2_mul(res, m1, m2)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat3x2) <<16)
      math::Mat2x2_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat4x2) <<16)
      math::Mat2x2_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x3) <<8 +(math::#type_Mat2x2) <<16)
      math::Mat2x3_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x3) <<8 +(math::#type_Mat3x2) <<16)
      math::Mat2x3_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x3) <<8 +(math::#type_Mat4x2) <<16)
      math::Mat2x3_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x4) <<8 +(math::#type_Mat2x2) <<16)
      math::Mat2x4_mul_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x4) <<8 +(math::#type_Mat3x2) <<16)
      math::Mat2x4_mul_Mat3x2(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x4) <<8 +(math::#type_Mat4x2) <<16)
      math::Mat2x4_mul_Mat4x2(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x2) <<8 +(math::#type_Mat2x3) <<16)
      math::Mat3x2_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x2) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x2_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x2) <<8 +(math::#type_Mat4x3) <<16)
      math::Mat3x2_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat2x3) <<16)
      math::Mat3x3_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x3_mul(res, m1, m2)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat4x3) <<16)
      math::Mat3x3_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x4) <<8 +(math::#type_Mat2x3) <<16)
      math::Mat3x4_mul_Mat2x3(res, m1, m2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x4) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x4_mul_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x4) <<8 +(math::#type_Mat4x3) <<16)
      math::Mat3x4_mul_Mat4x3(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x2) <<8 +(math::#type_Mat2x4) <<16)
      math::Mat4x2_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x2) <<8 +(math::#type_Mat3x4) <<16)
      math::Mat4x2_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x2) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x2_mul_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x3) <<8 +(math::#type_Mat2x4) <<16)
      math::Mat4x3_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x3) <<8 +(math::#type_Mat3x4) <<16)
      math::Mat4x3_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x3) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x3_mul_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat2x4) <<16)
      math::Mat4x4_mul_Mat2x4(res, m1, m2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat3x4) <<16)
      math::Mat4x4_mul_Mat3x4(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x4_mul(res, m1, m2)
    CompilerDefault
      CompilerError "[mul] unsupported type"
  CompilerEndSelect
EndMacro
Macro sub(res, m1, m2)
CompilerIf(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3)) Or(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3)) <>(((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3))
CompilerError "Types must be the same!"
CompilerEndIf
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_sub(res, m1, m2)
    CompilerCase math::#type_vec2
      math::vec2_sub(res, m1, m2)
    CompilerCase math::#type_vec3
      math::vec3_sub(res, m1, m2)
    CompilerCase math::#type_vec4
      math::vec4_sub(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_sub(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_sub(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_sub(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_sub(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_sub(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_sub(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_sub(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_sub(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_sub(res, m1, m2)
    CompilerDefault
      CompilerError "[sub] unsupported type"
  CompilerEndSelect
EndMacro
Macro set_float(res, f0=0.0,f1=,f2=,f3=,f4=,f5=,f6=,f7=,f8=,f9=,f10=,f11=,f12=,f13=,f14=,f15=)
CompilerIf (_math::dq#f1#_math::dq = "");set Scalar
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
      CompilerCase math::#type_quat
        math::quat_set_Scalar(res, f0)
      CompilerCase math::#type_vec2
        math::vec2_set_Scalar(res, f0)
      CompilerCase math::#type_vec3
        math::vec3_set_Scalar(res, f0)
      CompilerCase math::#type_vec4
        math::vec4_set_Scalar(res, f0)
      CompilerCase math::#type_Mat2x2
        math::Mat2x2_set_Scalar(res, f0)
      CompilerCase math::#type_Mat2x3
        math::Mat2x3_set_Scalar(res, f0)
      CompilerCase math::#type_Mat2x4
        math::Mat2x4_set_Scalar(res, f0)
      CompilerCase math::#type_Mat3x2
        math::Mat3x2_set_Scalar(res, f0)
      CompilerCase math::#type_Mat3x3
        math::Mat3x3_set_Scalar(res, f0)
      CompilerCase math::#type_Mat3x4
        math::Mat3x4_set_Scalar(res, f0)
      CompilerCase math::#type_Mat4x2
        math::Mat4x2_set_Scalar(res, f0)
      CompilerCase math::#type_Mat4x3
        math::Mat4x3_set_Scalar(res, f0)
      CompilerCase math::#type_Mat4x4
        math::Mat4x4_set_Scalar(res, f0)
      CompilerDefault
        CompilerError "[set_float] unsupported type"
    CompilerEndSelect
  CompilerElse
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
      CompilerCase math::#type_quat
        math::quat_set_float(res, f0, f1, f2, f3)
      CompilerCase math::#type_vec2
        math::vec2_set_float(res, f0, f1)
      CompilerCase math::#type_vec3
        math::vec3_set_float(res, f0, f1, f2)
      CompilerCase math::#type_vec4
        math::vec4_set_float(res, f0, f1, f2, f3)
      CompilerCase math::#type_Mat2x2
        math::Mat2x2_set_float(res, f0, f1, f2, f3)
      CompilerCase math::#type_Mat2x3
        math::Mat2x3_set_float(res, f0, f1, f2, f3, f4, f5)
      CompilerCase math::#type_Mat2x4
        math::Mat2x4_set_float(res, f0, f1, f2, f3, f4, f5, f6, f7)
      CompilerCase math::#type_Mat3x2
        math::Mat3x2_set_float(res, f0, f1, f2, f3, f4, f5)
      CompilerCase math::#type_Mat3x3
        math::Mat3x3_set_float(res, f0, f1, f2, f3, f4, f5, f6, f7, f8)
      CompilerCase math::#type_Mat3x4
        math::Mat3x4_set_float(res, f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)
      CompilerCase math::#type_Mat4x2
        math::Mat4x2_set_float(res, f0, f1, f2, f3, f4, f5, f6, f7)
      CompilerCase math::#type_Mat4x3
        math::Mat4x3_set_float(res, f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)
      CompilerCase math::#type_Mat4x4
        math::Mat4x4_set_float(res, f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15)
      CompilerDefault
        CompilerError "[set_float] unsupported type"
    CompilerEndSelect
  CompilerEndIf
EndMacro
Macro set(res, m, v1=, v2=, v3=)
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3)))<<8)
CompilerCase ((math::#type_quat) +(math::#type_quat) <<8);quat
      math::quat_set(res, m)
CompilerCase ((math::#type_quat) +(math::#type_vec3) <<8)
      CompilerIf _math::dq#v1#_math::dq = ""
        math::quat_set_eulerAngle(res, m)
      CompilerElse
        math::quat_set_vec3_vec3(res, m, v1)
      CompilerEndIf      
CompilerCase ((math::#type_quat) +(math::#type_mat3x3) <<8)
      math::quat_set_mat3x3(res, m)
CompilerCase ((math::#type_quat) +(math::#type_mat4x4) <<8)
      math::quat_set_mat4x4(res, m)
CompilerCase ((math::#type_mat3x3) +(math::#type_quat) <<8)
      math::mat3x3_set_quat(res, m)
CompilerCase ((math::#type_mat4x4) +(math::#type_quat) <<8)
      math::mat4x4_set_quat(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_vec2) <<8);mat vec
      math::Mat2x2_set_Vec2(res, m, v1)
CompilerCase ((math::#type_Mat2x3) +(math::#type_vec3) <<8)
      math::Mat2x3_set_Vec3(res, m, v1)
CompilerCase ((math::#type_Mat2x4) +(math::#type_vec4) <<8)
      math::Mat2x4_set_Vec4(res, m, v1)
CompilerCase ((math::#type_Mat3x2) +(math::#type_vec2) <<8)
      math::Mat3x2_set_Vec2(res, m, v1, v2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_vec3) <<8)
      math::Mat3x3_set_Vec3(res, m, v1, v2)
CompilerCase ((math::#type_Mat3x4) +(math::#type_vec4) <<8)
      math::Mat3x4_set_Vec4(res, m, v1, v2)
CompilerCase ((math::#type_Mat4x2) +(math::#type_vec2) <<8)
      math::Mat4x2_set_Vec2(res, m, v1, v2, v3)
CompilerCase ((math::#type_Mat4x3) +(math::#type_vec3) <<8)
      math::Mat4x3_set_Vec3(res, m, v1, v2, v3)
CompilerCase ((math::#type_Mat4x4) +(math::#type_vec4) <<8)
      math::Mat4x4_set_Vec4(res, m, v1, v2, v3)
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8);vec vec
      math::vec2_set(res, m)
CompilerCase ((math::#type_vec2) +(math::#type_vec3) <<8)
      math::vec2_set(res, m)
CompilerCase ((math::#type_vec2) +(math::#type_vec4) <<8)
      math::vec2_set(res, m)
CompilerCase ((math::#type_vec3) +(math::#type_vec2) <<8);vec vec
      math::vec3_set_vec2(res, m, 0)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8)
      math::vec3_set(res, m)
CompilerCase ((math::#type_vec3) +(math::#type_vec4) <<8)
      math::vec3_set_vec4(res, m)
CompilerCase ((math::#type_vec4) +(math::#type_vec3) <<8);vec vec
      math::vec4_set_vec3(res, m, 0)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8)
      math::vec4_set(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x2) <<8);mat mat
      math::Mat2x2_set(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x3) <<8)
      math::Mat2x2_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x4) <<8)
      math::Mat2x2_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x2) <<8)
      math::Mat2x2_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x3) <<8)
      math::Mat2x2_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat3x4) <<8)
      math::Mat2x2_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x2) <<8)
      math::Mat2x2_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x3) <<8)
      math::Mat2x2_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat4x4) <<8)
      math::Mat2x2_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x2) <<8)
      math::Mat2x3_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x3) <<8)
      math::Mat2x3_set(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat2x4) <<8)
      math::Mat2x3_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x2) <<8)
      math::Mat2x3_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x3) <<8)
      math::Mat2x3_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat3x4) <<8)
      math::Mat2x3_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x2) <<8)
      math::Mat2x3_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x3) <<8)
      math::Mat2x3_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat2x3) +(math::#type_Mat4x4) <<8)
      math::Mat2x3_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x2) <<8)
      math::Mat2x4_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x3) <<8)
      math::Mat2x4_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat2x4) <<8)
      math::Mat2x4_set(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x2) <<8)
      math::Mat2x4_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x3) <<8)
      math::Mat2x4_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat3x4) <<8)
      math::Mat2x4_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x2) <<8)
      math::Mat2x4_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x3) <<8)
      math::Mat2x4_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat2x4) +(math::#type_Mat4x4) <<8)
      math::Mat2x4_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x2) <<8)
      math::Mat3x2_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x3) <<8)
      math::Mat3x2_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat2x4) <<8)
      math::Mat3x2_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x2) <<8)
      math::Mat3x2_set(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x3) <<8)
      math::Mat3x2_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat3x4) <<8)
      math::Mat3x2_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x2) <<8)
      math::Mat3x2_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x3) <<8)
      math::Mat3x2_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat3x2) +(math::#type_Mat4x4) <<8)
      math::Mat3x2_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x2) <<8)
      math::Mat3x3_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x3) <<8)
      math::Mat3x3_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat2x4) <<8)
      math::Mat3x3_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x2) <<8)
      math::Mat3x3_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x3) <<8)
      math::Mat3x3_set(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x4) <<8)
      math::Mat3x3_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x2) <<8)
      math::Mat3x3_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x3) <<8)
      math::Mat3x3_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat4x4) <<8)
      math::Mat3x3_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x2) <<8)
      math::Mat3x4_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x3) <<8)
      math::Mat3x4_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat2x4) <<8)
      math::Mat3x4_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x2) <<8)
      math::Mat3x4_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x3) <<8)
      math::Mat3x4_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat3x4) <<8)
      math::Mat3x4_set(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x2) <<8)
      math::Mat3x4_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x3) <<8)
      math::Mat3x4_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat3x4) +(math::#type_Mat4x4) <<8)
      math::Mat3x4_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x2) <<8)
      math::Mat4x2_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x3) <<8)
      math::Mat4x2_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat2x4) <<8)
      math::Mat4x2_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x2) <<8)
      math::Mat4x2_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x3) <<8)
      math::Mat4x2_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat3x4) <<8)
      math::Mat4x2_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x2) <<8)
      math::Mat4x2_set(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x3) <<8)
      math::Mat4x2_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat4x2) +(math::#type_Mat4x4) <<8)
      math::Mat4x2_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x2) <<8)
      math::Mat4x3_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x3) <<8)
      math::Mat4x3_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat2x4) <<8)
      math::Mat4x3_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x2) <<8)
      math::Mat4x3_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x3) <<8)
      math::Mat4x3_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat3x4) <<8)
      math::Mat4x3_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x2) <<8)
      math::Mat4x3_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x3) <<8)
      math::Mat4x3_set(res, m)
CompilerCase ((math::#type_Mat4x3) +(math::#type_Mat4x4) <<8)
      math::Mat4x3_set_Mat4x4(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x2) <<8)
      math::Mat4x4_set_Mat2x2(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x3) <<8)
      math::Mat4x4_set_Mat2x3(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat2x4) <<8)
      math::Mat4x4_set_Mat2x4(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x2) <<8)
      math::Mat4x4_set_Mat3x2(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x3) <<8)
      math::Mat4x4_set_Mat3x3(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat3x4) <<8)
      math::Mat4x4_set_Mat3x4(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x2) <<8)
      math::Mat4x4_set_Mat4x2(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x3) <<8)
      math::Mat4x4_set_Mat4x3(res, m)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x4) <<8)
      math::Mat4x4_set(res, m)
    CompilerDefault
      CompilerError "[set] unsupported type"
  CompilerEndSelect
EndMacro
Macro div(res, m1, m2)
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m1\__type0__)&1)<<0) +((TypeOf(m1\__type1__)&1)<<1) +((TypeOf(m1\__type2__)&1)<<2) +((TypeOf(m1\__type3__)&1)<<3))) <<8 +((((TypeOf(m2\__type0__)&1)<<0) +((TypeOf(m2\__type1__)&1)<<1) +((TypeOf(m2\__type2__)&1)<<2) + ((TypeOf(m2\__type3__)&1)<<3)))<<16)
CompilerCase ((math::#type_vec2) +(math::#type_Mat2x2) <<8 +(math::#type_vec2) <<16); mat vec
      math::Mat2x2_div_Vec2(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_Mat3x3) <<8 +(math::#type_vec3) <<16)
      math::Mat3x3_div_Vec3(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_Mat4x4) <<8 +(math::#type_vec4) <<16)
      math::Mat4x4_div_Vec4(res, m1, m2)
    CompilerDefault
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8 +(math::#type_Mat2x2) <<16); mat/vec
      math::Vec2_div_Mat2x2(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_Mat3x3) <<16)
      math::Vec3_div_Mat3x3(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_Mat4x4) <<16)
      math::Vec4_div_Mat4x4(res, m1, m2)
CompilerCase ((math::#type_vec2) +(math::#type_vec2) <<8 +(math::#type_vec2) <<16); vec
      math::vec2_div(res, m1, m2)
CompilerCase ((math::#type_vec3) +(math::#type_vec3) <<8 +(math::#type_vec3) <<16)
      math::vec3_div(res, m1, m2)
CompilerCase ((math::#type_vec4) +(math::#type_vec4) <<8 +(math::#type_vec4) <<16)
      math::vec4_div(res, m1, m2)
CompilerCase ((math::#type_Mat2x2) +(math::#type_Mat2x2) <<8 +(math::#type_Mat2x2) <<16); mat
      math::Mat2x2_div(res, m1, m2)
CompilerCase ((math::#type_Mat3x3) +(math::#type_Mat3x3) <<8 +(math::#type_Mat3x3) <<16)
      math::Mat3x3_div(res, m1, m2)
CompilerCase ((math::#type_Mat4x4) +(math::#type_Mat4x4) <<8 +(math::#type_Mat4x4) <<16)
      math::Mat4x4_div(res, m1, m2)
    CompilerDefault
      CompilerError "[div] unsupported type"
  CompilerEndSelect
EndMacro
Macro inverse(res, m)  
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_inverse(res, M)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_inverse(res, m)       
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_inverse(res, m)       
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_inverse(res, m)       
    CompilerDefault
      Debug "[inverse] Not supported type"
  CompilerEndSelect  
EndMacro
Macro transpose(res, m)  
CompilerSelect(((((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) +((TypeOf(res\__type3__)&1)<<3))) +((((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3)))<<8)
CompilerCase ((math::#type_mat2x2) +(math::#type_mat2x2) <<8)
      math::mat2x2_transpose(res, m)
CompilerCase ((math::#type_mat2x3) +(math::#type_mat3x2) <<8)
      math::mat2x3_transpose(res, m)      
CompilerCase ((math::#type_mat2x4) +(math::#type_mat4x2) <<8)
      math::mat2x4_transpose(res, m)
CompilerCase ((math::#type_mat3x2) +(math::#type_mat2x3) <<8)
      math::mat3x2_transpose(res, m)
CompilerCase ((math::#type_mat3x3) +(math::#type_mat3x3) <<8)
      math::mat3x3_transpose(res, m)
CompilerCase ((math::#type_mat3x4) +(math::#type_mat4x3) <<8)
      math::mat3x4_transpose(res, m)
CompilerCase ((math::#type_mat4x2) +(math::#type_mat2x4) <<8)
      math::mat4x2_transpose(res, m)
CompilerCase ((math::#type_mat4x3) +(math::#type_mat3x4) <<8)
      math::mat4x3_transpose(res, m)
CompilerCase ((math::#type_mat4x4) +(math::#type_mat4x4) <<8)
      math::mat4x4_transpose(res, m)
    CompilerDefault
      CompilerError "[transpose] Not supported mat"
  CompilerEndSelect  
EndMacro
Macro determinant(m)
_math::compute_determinant(m,(((TypeOf(m\__type0__)&1)<<0) +((TypeOf(m\__type1__)&1)<<1) +((TypeOf(m\__type2__)&1)<<2) + ((TypeOf(m\__type3__)&1)<<3)))
EndMacro
Macro dot(a, b)
_math::compute_Dot(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), b)
EndMacro
Macro length(a)
Sqr(_math::compute_Dot(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), a))
EndMacro
Macro length2(a)
_math::compute_Dot(a,(((TypeOf(a\__type0__)&1)<<0) +((TypeOf(a\__type1__)&1)<<1) +((TypeOf(a\__type2__)&1)<<2) + ((TypeOf(a\__type3__)&1)<<3)), a)
EndMacro
Macro normalize(res, v)
_math::compute_normalize(res,(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3)), v)
EndMacro
Macro orientate3(resMat3x3, angleFloatOrVec3)
  CompilerIf TypeOf(angleFloatOrVec3) <> #PB_Structure
    math::orientate3_float(resMat3x3, angleFloatOrVec3)
  CompilerElse
    math::orientate3_vec3(resMat3x3, angleFloatOrVec3)
  CompilerEndIf
EndMacro
Macro add_scalar(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_add_scalar(res, m1, m2)
    CompilerCase math::#type_vec2
      math::vec2_add_scalar(res, m1, m2)
    CompilerCase math::#type_vec3
      math::vec3_add_scalar(res, m1, m2)
    CompilerCase math::#type_vec4
      math::vec4_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_add_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_add_scalar(res, m1, m2)
    CompilerDefault
      CompilerError "[add_scalar] unsupported type"
  CompilerEndSelect
EndMacro
Macro sub_scalar(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_sub_scalar(res, m1, m2)
    CompilerCase math::#type_vec2
      math::vec2_sub_scalar(res, m1, m2)
    CompilerCase math::#type_vec3
      math::vec3_sub_scalar(res, m1, m2)
    CompilerCase math::#type_vec4
      math::vec4_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_sub_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_sub_scalar(res, m1, m2)
    CompilerDefault
      CompilerError "[sub_scalar] unsupported type"
  CompilerEndSelect
EndMacro
Macro mul_scalar(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_mul_scalar(res, m1, m2)
    CompilerCase math::#type_vec2
      math::vec2_mul_scalar(res, m1, m2)
    CompilerCase math::#type_vec3
      math::vec3_mul_scalar(res, m1, m2)
    CompilerCase math::#type_vec4
      math::vec4_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_mul_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_mul_scalar(res, m1, m2)
    CompilerDefault
      CompilerError "[mul_scalar] unsupported type"
  CompilerEndSelect
EndMacro
Macro div_scalar(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::quat_div_scalar(res, m1, m2)
    CompilerCase math::#type_vec2
      math::vec2_div_scalar(res, m1, m2)
    CompilerCase math::#type_vec3
      math::vec3_div_scalar(res, m1, m2)
    CompilerCase math::#type_vec4
      math::vec4_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::Mat2x2_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::Mat2x3_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::Mat2x4_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::Mat3x2_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::Mat3x3_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::Mat3x4_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::Mat4x2_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::Mat4x3_div_scalar(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::Mat4x4_div_scalar(res, m1, m2)
    CompilerDefault
      CompilerError "[add_scalar] unsupported type"
  CompilerEndSelect
EndMacro
Macro scalar_add(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::scalar_add_quat(res, m1, m2)
    CompilerCase math::#type_vec2
      math::scalar_add_vec2(res, m1, m2)
    CompilerCase math::#type_vec3
      math::scalar_add_vec3(res, m1, m2)
    CompilerCase math::#type_vec4
      math::scalar_add_vec4(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::scalar_add_Mat2x2(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::scalar_add_Mat2x3(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::scalar_add_Mat2x4(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::scalar_add_Mat3x2(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::scalar_add_Mat3x3(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::scalar_add_Mat3x4(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::scalar_add_Mat4x2(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::scalar_add_Mat4x3(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::scalar_add_Mat4x4(res, m1, m2)
    CompilerDefault
      CompilerError "[scalar_add] unsupported type"
  CompilerEndSelect
EndMacro
Macro scalar_sub(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::scalar_sub_quat(res, m1, m2)
    CompilerCase math::#type_vec2
      math::scalar_sub_vec2(res, m1, m2)
    CompilerCase math::#type_vec3
      math::scalar_sub_vec3(res, m1, m2)
    CompilerCase math::#type_vec4
      math::scalar_sub_vec4(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::scalar_sub_Mat2x2(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::scalar_sub_Mat2x3(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::scalar_sub_Mat2x4(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::scalar_sub_Mat3x2(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::scalar_sub_Mat3x3(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::scalar_sub_Mat3x4(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::scalar_sub_Mat4x2(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::scalar_sub_Mat4x3(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::scalar_sub_Mat4x4(res, m1, m2)
    CompilerDefault
      CompilerError "[scalar_sub] unsupported type"
  CompilerEndSelect
EndMacro
Macro scalar_mul(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::scalar_mul_quat(res, m1, m2)
    CompilerCase math::#type_vec2
      math::scalar_mul_vec2(res, m1, m2)
    CompilerCase math::#type_vec3
      math::scalar_mul_vec3(res, m1, m2)
    CompilerCase math::#type_vec4
      math::scalar_mul_vec4(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::scalar_mul_Mat2x2(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::scalar_mul_Mat2x3(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::scalar_mul_Mat2x4(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::scalar_mul_Mat3x2(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::scalar_mul_Mat3x3(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::scalar_mul_Mat3x4(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::scalar_mul_Mat4x2(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::scalar_mul_Mat4x3(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::scalar_mul_Mat4x4(res, m1, m2)
    CompilerDefault
      CompilerError "[scalar_mul] unsupported type"
  CompilerEndSelect
EndMacro
Macro scalar_div(res, m1, m2)
CompilerSelect(((TypeOf(res\__type0__)&1)<<0) +((TypeOf(res\__type1__)&1)<<1) +((TypeOf(res\__type2__)&1)<<2) + ((TypeOf(res\__type3__)&1)<<3))
    CompilerCase math::#type_quat
      math::scalar_div_quat(res, m1, m2)
    CompilerCase math::#type_vec2
      math::scalar_div_vec2(res, m1, m2)
    CompilerCase math::#type_vec3
      math::scalar_div_vec3(res, m1, m2)
    CompilerCase math::#type_vec4
      math::scalar_div_vec4(res, m1, m2)
    CompilerCase math::#type_Mat2x2
      math::scalar_div_Mat2x2(res, m1, m2)
    CompilerCase math::#type_Mat2x3
      math::scalar_div_Mat2x3(res, m1, m2)
    CompilerCase math::#type_Mat2x4
      math::scalar_div_Mat2x4(res, m1, m2)
    CompilerCase math::#type_Mat3x2
      math::scalar_div_Mat3x2(res, m1, m2)
    CompilerCase math::#type_Mat3x3
      math::scalar_div_Mat3x3(res, m1, m2)
    CompilerCase math::#type_Mat3x4
      math::scalar_div_Mat3x4(res, m1, m2)
    CompilerCase math::#type_Mat4x2
      math::scalar_div_Mat4x2(res, m1, m2)
    CompilerCase math::#type_Mat4x3
      math::scalar_div_Mat4x3(res, m1, m2)
    CompilerCase math::#type_Mat4x4
      math::scalar_div_Mat4x4(res, m1, m2)
    CompilerDefault
      CompilerError "[scalar_div] unsupported type"
  CompilerEndSelect
EndMacro
;}
;-----------------------
;- in.pbi
;{

Macro in_Vec2()
  _math::in_mem("vec2 "+ MacroExpandedCount, SizeOf(math::vec2))
EndMacro
Macro in_Vec3()
  _math::in_mem("vec3 "+ MacroExpandedCount, SizeOf(math::vec3))
EndMacro
Macro in_Vec4()
  _math::in_mem("vec4 "+ MacroExpandedCount, SizeOf(math::vec4))
EndMacro
Macro in_Mat2x2()
  _math::in_mem("mat2x2 "+ MacroExpandedCount, SizeOf(math::Mat2x2))
EndMacro
Macro in_Mat3x3()
  _math::in_mem("mat3x3 "+ MacroExpandedCount, SizeOf(math::Mat3x3))
EndMacro
Macro in_Mat4x4()
  _math::in_mem("mat4x4 "+ MacroExpandedCount, SizeOf(math::Mat4x4))
EndMacro
;}
  Global.vec4 V4_0000,V4_0001,V4_0010,V4_0011,V4_0100,V4_0101,V4_0110,V4_0111
  Global.vec4 V4_1000,V4_1001,V4_1010,V4_1011,V4_1100,V4_1101,V4_1110,V4_1111
  Global.vec3 V3_000,V3_100,V3_010,V3_001,V3_110,V3_101,V3_011,V3_111
  Global.vec2 V2_00,V2_10,V2_01,V2_11
  Global.mat4x4 M4_1
  Global.mat3x3 M3_1
  Global.Mat2x2 M2_1
  Global.quat Q_1
  Global.f one
EndDeclareModule
XIncludeFile "_module__math_.pbi"
XIncludeFile "_declare__math.pbi"
XIncludeFile "_module__math.pbi"
XIncludeFile "_module_math.pbi"
