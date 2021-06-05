Module _math
  Procedure init()
    Protected.l i
    For i=0 To math::#type_matMax-1
      matFloatSize(i) = matCol(i) * matRow(i)
    Next
    matFloatSize(math::#type_vec2)=2
    matFloatSize(math::#type_vec3)=3
    matFloatSize(math::#type_vec4)=4
    matFloatSize(math::#type_quat)=4
  EndProcedure
  init()
;-----------------------
;- _func_common_inl.pbi
;{

Procedure vec_Step_Vector(*res.math::vec4, resType.l, *edge.math::vec4, *x.math::vec4)
  Protected.l i
  For i=0 To resType-1
    If *x\f[i] < *edge\f[i]
      *res\f[i] = 0.0
    Else
      *res\f[i] = 1.0
    EndIf
  Next
  ProcedureReturn *res
EndProcedure
Procedure vec_Step_Vector_Scalar(*res.math::vec4, resType.l, edge.f, *x.math::vec4)
  Protected.l i
  For i=0 To resType-1
    If *x\f[i] < edge
      *res\f[i] = 0.0
    Else
      *res\f[i] = 1.0
    EndIf
  Next
  ProcedureReturn *res
EndProcedure
Procedure vec_smoothstep_vector(*res.math::vec4, resType.l, *edge0.math::vec4, *edge1.math::vec4, *x.math::vec4)
  Protected.f tmp
  Protected.l i
  For i=0 To resType-1
    tmp = math::clamp_f((*x\f[i] - *edge0\f[i]) / (*edge1\f[i] - *edge0\f[i]), 0.0, 1.0)
    *res\f[i] = tmp * tmp * (3.0 - 2.0 * tmp)
  Next
  ProcedureReturn *res
EndProcedure
Procedure vec_smoothstep_vector_Scalar(*res.math::vec4, resType.l, edge0.f, edge1.f, *x.math::vec4)
  Protected.f tmp
  Protected.l i
  For i=0 To resType-1
    tmp = math::clamp_f((*x\f[i] - edge0) / (edge1 - edge0), 0.0, 1.0)
    *res\f[i] = tmp * tmp * (3.0 - 2.0 * tmp)
  Next
  ProcedureReturn *res
EndProcedure
Procedure.s string(*res.float, resType.l, NbDecimals.f)
  Protected.s str
  Protected.l i,a
  If resType < math::#type_vecmax
    str+"["
    For a=0 To _math::matFloatSize(resType)-1
      If a:str+", ":EndIf
      str+ StrF(*res\f,NbDecimals)
      *res + SizeOf(float)
    Next
    str+"]"
  Else    
    Protected.l row = _math::matrow(restype)
    Protected.l col = _math::matcol(restype)
    str="{"
    For i=0 To col-1
      If i:str+", ":EndIf
      str+"["
      For a=0 To row-1
        If a:str+", ":EndIf
        str+ StrF(*res\f,NbDecimals)
        *res + SizeOf(float)
      Next
      str+"]"
    Next
    str+"}"
  EndIf  
  ProcedureReturn str
EndProcedure
Procedure.s stringBool(*res.long, resType.l)
  Protected.s str
  Protected.l i,a
  If resType < math::#type_vecmax
    str+"["
    For a=0 To _math::matFloatSize(resType)-1
      If a:str+", ":EndIf
      str+ Str(*res\l)
      *res + SizeOf(long)
    Next
    str+"]"
  Else
    Protected.l row = _math::matrow(restype)
    Protected.l col = _math::matcol(restype)
    str="{"
    For i=0 To col-1
      If i:str+", ":EndIf
      str+"["
      For a=0 To row-1
        If a:str+", ":EndIf
        str+ Str(*res\l)
        *res + SizeOf(long)
      Next
      str+"]"
    Next
    str+"}"
  EndIf
  ProcedureReturn str
EndProcedure
Procedure Is_NAN(*resbool.long, resType.l, *x.float)
  Protected.l i
  For i=1 To _math::matFloatSize(resType)
    *resBOOl\l = Bool(IsNAN(*x\f))
    *resbool + SizeOf(long)
    *x + SizeOf(float)
  Next
  ProcedureReturn *resbool
EndProcedure
Procedure is_Inf(*resbool.long, resType.l, *x.float)
  Protected.l i
  For i=1 To _math::matFloatSize(resType)
    *resBOOl\l = Bool(IsInfinity(*x\f))
    *resbool + SizeOf(long)
    *x + SizeOf(float)
  Next
  ProcedureReturn *resbool
EndProcedure
Procedure.l bool_any(*res.long, resType)
  Protected.l i
  Protected.l ret = #False
  For i = 1 To _math::matfloatsize(resType)
    ret | *res\l
    *res + SizeOf(long)
  Next
  ProcedureReturn ret
EndProcedure
Procedure.l bool_all(*res.long, resType)
  Protected.l i
  Protected.l ret = #True
  For i = 1 To _math::matfloatsize(resType)
    ret & *res\l
    *res + SizeOf(long)
  Next
  ProcedureReturn ret
EndProcedure
Procedure bool_not(*res.long, resType, *x.long)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (Not *x\l)
    *res + SizeOf(long)
    *x + SizeOf(long)
  Next
  ProcedureReturn *res
EndProcedure
Procedure bool_and(*res.long, resType.l, *m1.long, *m2.long)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (*m1\l And *m2\l)
    *res + SizeOf(long)
    *m1 + SizeOf(long)
    *m2 + SizeOf(long)
  Next
  ProcedureReturn *res
EndProcedure
Procedure bool_or(*res.long, resType.l, *m1.long, *m2.long)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (*m1\l Or *m2\l)
    *res + SizeOf(long)
    *m1 + SizeOf(long)
    *m2 + SizeOf(long)
  Next
  ProcedureReturn *res
EndProcedure
Procedure.l do_all(*func.prot_cmp, resType.l, *m1.float, *m2.float, epsilon.f)
  Protected *buf = AllocateMemory( _math::matfloatsize(resType) * SizeOf( float) )
  Protected.l ret
  *func(*buf, resType.l, *m1.float, *m2.float, epsilon.f)
  ret = bool_all(*buf, resType)
  FreeMemory(*buf)
  ProcedureReturn ret
EndProcedure
Procedure.l do_any(*func.prot_cmp, resType.l, *m1.float, *m2.float, epsilon.f)
  Protected *buf = AllocateMemory( _math::matfloatsize(resType) * SizeOf( float) )
  Protected.l ret
  *func(*buf, resType.l, *m1.float, *m2.float, epsilon.f)
  ret = bool_any(*buf, resType)
  FreeMemory(*buf)
  ProcedureReturn ret
EndProcedure
Procedure equal(*res.long, resType.l, *m1.float, *m2.float, epsilon.f)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (Abs(*m1\f - *m2\f) <= epsilon)
    *res + SizeOf(long)
    *m1 + SizeOf(float)
    *m2 + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure notequal(*res.long, resType.l, *m1.float, *m2.float, epsilon.f)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (Not(Abs(*m1\f - *m2\f) <= epsilon))
    *res + SizeOf(long)
    *m1 + SizeOf(float)
    *m2 + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure lessThan(*res.long, resType.l, *m1.float, *m2.float)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (*m1\f < *m2\f)
    *res + SizeOf(long)
    *m1 + SizeOf(float)
    *m2 + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure lessThanEqual(*res.long, resType.l, *m1.float, *m2.float)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (*m1\f =< *m2\f)
    *res + SizeOf(long)
    *m1 + SizeOf(float)
    *m2 + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure greaterThan(*res.long, resType.l, *m1.float, *m2.float)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (*m1\f > *m2\f)
    *res + SizeOf(long)
    *m1 + SizeOf(float)
    *m2 + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure greaterThanEqual(*res.long, resType.l, *m1.float, *m2.float)     
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\l = Bool (*m1\f >= *m2\f)
    *res + SizeOf(long)
    *m1 + SizeOf(float)
    *m2 + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure long_from_float(*l.long, resType, *f.float)
  Protected.l i
  For i=1 To _math::matFloatSize(resType)
    *l\l = *f\f
    *l + SizeOf(long)
    *f + SizeOf(float)
  Next
  ProcedureReturn *l
EndProcedure
Procedure float_from_long(*f.float, resType, *l.long)
  Protected.l i
  For i=1 To _math::matFloatSize(resType)    
    *f\f = *l\l
    *l + SizeOf(long)
    *f + SizeOf(float)
  Next
  ProcedureReturn *f
EndProcedure
Procedure compute_mix_scalar(*res.float, resType.l, *x.float, *y.float, a.f)
  If restype = math::#type_quat
    ProcedureReturn math::quat_mix(*res, *x, *y, a)
  EndIf
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *x\f * (1-a) + *y\f * a
    *res + SizeOf(float)
    *x + SizeOf(float)
    *y + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_mix(*res.float, resType.l, *x.float, *y.float, *a.float)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *x\f * (1 - *a\f) + *y\f * *a\f
    *res + SizeOf(float)
    *x + SizeOf(float)
    *y + SizeOf(float)
    *a + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_function1(*res.float, resType.l, *func1.prot_function1, *x.float)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *func1(*x\f)
    *res + SizeOf(float)
    *x + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_function2(*res.float, resType.l, *func2.prot_function2, *x.float, *y.float)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *func2(*x\f, *y\f)
    *res + SizeOf(float)
    *x + SizeOf(float)
    *y + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_function2p(*res.float, resType.l, *func2.prot_function2p, *x.float, *y.float)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *func2(*x\f, *y)
    *res + SizeOf(float)
    *x + SizeOf(float)
    *y + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_function2s(*res.float, resType.l, *func2.prot_function2, *x.float, y.f)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *func2(*x\f, y)
    *res + SizeOf(float)
    *x + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_function3(*res.float, resType.l, *func3.prot_function3, *x.float, *y.float, *z.float)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *func3(*x\f, *y\f, *y\f)
    *res + SizeOf(float)
    *x + SizeOf(float)
    *y + SizeOf(float)
    *z + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_function3s(*res.float, resType.l, *func3.prot_function3, *x.float, y.f, z.f)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *func3(*x\f, y, z)
    *res + SizeOf(float)
    *x + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure.f min_f(a.f, b.f, c.f, d.f)
  If IsNAN(a) And IsNAN(b) And IsNAN(c) And IsNAN(d)
    ProcedureReturn NaN()
  EndIf
  If IsNAN(a)
    a=Infinity()
  EndIf
  If IsNAN(b)
    b=Infinity()
  EndIf
  If IsNAN(c)
    c=Infinity()
  EndIf
  If IsNAN(d)
    d=Infinity()
  EndIf
  If a < b
    If c < d
      If a < c
        ProcedureReturn a
      Else
        ProcedureReturn c
      EndIf
    Else
      If a < d
        ProcedureReturn a
      Else
        ProcedureReturn d
      EndIf
    EndIf
  Else
    If c < d
      If b < c
        ProcedureReturn b
      Else
        ProcedureReturn c
      EndIf
    Else
      If b < d
        ProcedureReturn b
      Else
        ProcedureReturn d
      EndIf
    EndIf
  EndIf  
EndProcedure
Procedure.f min2_f(a.f, b.f)
  If IsNAN(a) And IsNAN(b)
    ProcedureReturn NaN()
  EndIf
  If IsNAN(a)
    a=Infinity()
  EndIf
  If IsNAN(b)
    b=Infinity()
  EndIf
  If a < b
    ProcedureReturn a
  Else
    ProcedureReturn b   
  EndIf  
EndProcedure
Procedure.f max_f(a.f, b.f, c.f, d.f)
  If IsNAN(a) And IsNAN(b) And IsNAN(c) And IsNAN(d)
    ProcedureReturn NaN()
  EndIf
  If IsNAN(a)
    a=-Infinity()
  EndIf
  If IsNAN(b)
    b=-Infinity()
  EndIf
  If IsNAN(c)
    c=-Infinity()
  EndIf
  If IsNAN(d)
    d=-Infinity()
  EndIf
  If a > b
    If c > d
      If a > c
        ProcedureReturn a
      Else
        ProcedureReturn c
      EndIf
    Else
      If a > d
        ProcedureReturn a
      Else
        ProcedureReturn d
      EndIf
    EndIf
  Else
    If c > d
      If b > c
        ProcedureReturn b
      Else
        ProcedureReturn c
      EndIf
    Else
      If b > d
        ProcedureReturn b
      Else
        ProcedureReturn d
      EndIf
    EndIf
  EndIf  
EndProcedure
Procedure.f max2_f(a.f, b.f)
  If IsNAN(a) And IsNAN(b)
    ProcedureReturn NaN()
  EndIf
  If IsNAN(a)
    a=-Infinity()
  EndIf
  If IsNAN(b)
    b=-Infinity()
  EndIf
  If a > b
    ProcedureReturn a
  Else
    ProcedureReturn b   
  EndIf  
EndProcedure
;}
;-----------------------
;- _func_geometric_inl.pbi
;{

Procedure.f compute_Dot(*a.math::vec4, aType.l, *b.math::vec4)
  Protected.l i
  Protected.f result
  CompilerIf #PB_Compiler_Debugger
    If atype > math::#type_vecmax
      Debug "only Vectors"
      CallDebugger
    EndIf
  CompilerEndIf
  For i = 0 To _math::matFloatSize(aType) - 1
    result + *a\f[i] * *b\f[i]
  Next
  ProcedureReturn result
EndProcedure
Procedure.f compute_distance2(*a.float, aType.l, *b.float)
  Protected.l i
  Protected.f result, tmp
  For i = 1 To _math::matFloatSize(aType)
    tmp = *b\f - *a\f
    result + tmp * tmp
    *b+SizeOf(float)
    *a+SizeOf(float)    
  Next
  ProcedureReturn result
EndProcedure
Procedure compute_normalize(*res.math::vec4, resType.l, *v.math::vec4)
  If resType = math::#type_quat
    ProcedureReturn math::quat_normalize(*res,*v)
  EndIf  
  Protected.l i
  Protected.f scalar = math::inversesqrt_f( compute_dot(*v, resType, *v) )
  ;only vectors does compute_dot
  For i = 0 To _math::matFloatSize(resType) -1
    *res\f[i] = *v\f[i] * scalar
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_faceforward(*res.math::vec4, resType.l, *n.math::vec4, *i.math::vec4, *nref.math::vec4)
  Protected.l i
  ;only vectors does compute_dot
  If compute_dot(*nref, restype, *i) < 0.0
    For i = 0 To _math::matFloatSize(resType) -1
      *res\f[i] =  *n\f[i]
    Next
  Else
    For i = 0 To resType -1
      *res\f[i] =  - *n\f[i]
    Next
  EndIf
  ProcedureReturn *res
EndProcedure
Procedure compute_reflect(*res.math::vec4, resType.l, *i.math::vec4, *n.math::vec4)  
  Protected.l i
  ;only vectors does compute_dot
  Protected.f scalar =  compute_dot(*n, resType, *i) * 2
  For i = 0 To _math::matFloatSize(resType) - 1
    *res\f[i] = *i\f[i] - *n\f[i] * scalar
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_refract(*res.math::vec4, resType.l, *I.math::vec4, *N.math::vec4, eta.f)
  Protected.l i
  ;only vectors does compute_dot
  Protected.f dotValue = compute_dot(*n, resType, *I)
  Protected.f k = 1 - eta * eta * (1 - dotValue * dotValue)
  If k >= 0.0
    k = eta * dotValue + Sqr(k)
    For i=0 To _math::matFloatSize(resType) -1
      *res\f[i] = eta * *I\f[i] - k * *N\f[i]
    Next
  Else
    For i=0 To _math::matFloatSize(resType) -1
      *res\f[i] = 0.0
    Next
  EndIf
  ProcedureReturn *res
EndProcedure
;}
;-----------------------
;- _func_matrix_inl.pbi
;{

Procedure compute_matrixCompMult(*res.float, resType.l, *x.float, *y.float)
  Protected.l i
  For i = 1 To _math::matfloatsize(resType)
    *res\f = *x\f * *y\f
    *res + SizeOf(float)
    *x + SizeOf(float)
    *y + SizeOf(float)
  Next
  ProcedureReturn *res
EndProcedure
Procedure compute_outerProduct(*res.float, resType.l, *c.math::vec4, *r.math::vec4)
  Protected.l row = _math::matrow(restype)
  Protected.l col = _math::matcol(restype)  
  Protected.l i,a
  CompilerIf #PB_Compiler_Debugger
    If row = 0 Or col = 0
      Debug "[compute_outerProduct] Mats only"
      CallDebugger
    EndIf
  CompilerEndIf
  For i=0 To col-1
    For a=0 To row-1
      *res\f = *c\f[a] * *r\f[i]
      *res + SizeOf(float)
    Next
  Next
  ProcedureReturn *res
EndProcedure
Procedure.f compute_determinant(*res, resType.l)
  Select resType
    Case math::#type_mat2x2 : ProcedureReturn math::mat2x2_determinant(*res)
    Case math::#type_mat3x3 : ProcedureReturn math::mat3x3_determinant(*res)
    Case math::#type_mat4x4 : ProcedureReturn math::mat4x4_determinant(*res)
    Default
      Debug "[compute_determinant] unsupported type"
      CallDebugger
  EndSelect
  ProcedureReturn *res
EndProcedure
;}
;-----------------------
;- _in_inl.pbi
;{

Procedure in_mem(name.s, size.i)
  Static NewMap *cache()
  If name = "CLEAR"
    ForEach *cache()
      If *cache()
        FreeMemory(*cache())
      EndIf
    Next
    ClearMap(*cache())
    ProcedureReturn #False
  EndIf
  If *cache(name) = #Null
    *cache(name) = AllocateMemory(size)
  EndIf
  ProcedureReturn *cache(name)
EndProcedure
;}
EndModule
