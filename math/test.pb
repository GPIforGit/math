XIncludeFile "math.pbi"

;XIncludeFile "..\..\math\math.pbi"


EnableExplicit
Define.l sum, err
Define output.s

Macro call(x)
  err=test_#x()
  output + _math::dq[x]_math::dq +": "+ err +#LF$
  sum+err
EndMacro

;- vector_type -------------------

Procedure.l  Test_Vec2_operators()
  Protected.l error =0
  Protected.math::vec2l Bool
  Protected.math::Vec2 res,a,b,c,d,e,f,g,h,i,j,k,l,m,n
  math::set_float(a, 1.0, 2.0, 3.0, 4.0)
  math::set_float(b, 4.0, 5.0, 6.0, 7.0)
  
  math::let(  C, A, +, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::let(  D, B, -, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::let(  E, A, *, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::let(  f, B, /, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  math::let_scalar(  g, a, +, 1.0)
  math::set_float(res, 2, 3, 4, 5)
  math::equal(Bool, g, Res)
  error + 1-math::all(bool)
  
  math::let_scalar(  h, B, -, 1.0)
  math::set_float(res, 3, 4, 5, 6)
  math::equal(Bool, h, Res)
  error + 1-math::all(bool)
  
  math::let_scalar( i, a, *, 2.0)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, i, Res)
  error + 1-math::all(bool)
  
  math::let_scalar( j, b, /, 2.0)
  math::set_float(res, 2, 2.5, 3, 3.5)
  math::equal(Bool, j, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( k, 1.0, +, a)
  math::set_float(res, 2,3,4,5)
  math::equal(Bool, k, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( l, 1.0, -, b)
  math::set_float(res, -3,-4,-5,-6)
  math::equal(Bool, l, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( m, 2.0, *, a)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, m, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( n, 2.0, /, b)
  math::set_float(res,0.5,2/5,2/6,2/7)
  math::equal(Bool, n, Res)
  error + 1-math::all(bool)
  
  ; --------
  
  math::set(C,A)
  math::let(C, C, +, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::set(D,B)
  math::let(D, D, -, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::set(E,A)
  math::Let(E,  E, *, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::set(f,b)
  math::Let(f,  f, /, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  math::set(g,a)
  math::let_scalar(g, g, +, 1.0)
  math::set_float(res, 2, 3, 4, 5)
  math::equal(Bool, g, Res)
  error + 1-math::all(bool)
  
  math::set(h,b)
  math::let_scalar(h,  h, -, 1.0)
  math::set_float(res, 3, 4, 5, 6)
  math::equal(Bool, h, Res)
  error + 1-math::all(bool)
  
  math::set(i,a)
  math::let_scalar(i, i, *, 2.0)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, i, Res)
  error + 1-math::all(bool)
  
  math::set(j,b)
  math::let_scalar(j, j, /, 2.0)
  math::set_float(res, 2, 2.5, 3, 3.5)
  math::equal(Bool, j, Res)
  error + 1-math::all(bool)
  
  ; --------
  
  math::add(  C, A,  b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::sub(  D, B, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::mul(  E, A, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::div(  f, B, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  ; -------
  
  math::set(C,A)
  math::add(C,  C, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::set(D,B)
  math::sub(D, D, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::set(E,A)
  math::mul(E,  E, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::set(f,b)
  math::div(f,  f, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  
  ProcedureReturn error  
  
EndProcedure
Procedure.l  Test_Vec3_operators()
  Protected.l error =0
  Protected.math::vec3l Bool
  Protected.math::Vec3 res,a,b,c,d,e,f,g,h,i,j,k,l,m,n
  math::set_float(a, 1.0, 2.0, 3.0, 4.0)
  math::set_float(b, 4.0, 5.0, 6.0, 7.0)
  
  math::let(  C, A, +, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::let(  D, B, -, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::let(  E, A, *, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::let(  f, B, /, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  math::let_scalar(  g, a, +, 1.0)
  math::set_float(res, 2, 3, 4, 5)
  math::equal(Bool, g, Res)
  error + 1-math::all(bool)
  
  math::let_scalar(  h, B, -, 1.0)
  math::set_float(res, 3, 4, 5, 6)
  math::equal(Bool, h, Res)
  error + 1-math::all(bool)
  
  math::let_scalar( i, a, *, 2.0)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, i, Res)
  error + 1-math::all(bool)
  
  math::let_scalar( j, b, /, 2.0)
  math::set_float(res, 2, 2.5, 3, 3.5)
  math::equal(Bool, j, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( k, 1.0, +, a)
  math::set_float(res, 2,3,4,5)
  math::equal(Bool, k, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( l, 1.0, -, b)
  math::set_float(res, -3,-4,-5,-6)
  math::equal(Bool, l, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( m, 2.0, *, a)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, m, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( n, 2.0, /, b)
  math::set_float(res,0.5,2/5,2/6,2/7)
  math::equal(Bool, n, Res)
  error + 1-math::all(bool)
  
  ; --------
  
  math::set(C,A)
  math::let(C, C, +, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::set(D,B)
  math::let(D, D, -, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::set(E,A)
  math::Let(E,  E, *, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::set(f,b)
  math::Let(f,  f, /, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  math::set(g,a)
  math::let_scalar(g, g, +, 1.0)
  math::set_float(res, 2, 3, 4, 5)
  math::equal(Bool, g, Res)
  error + 1-math::all(bool)
  
  math::set(h,b)
  math::let_scalar(h,  h, -, 1.0)
  math::set_float(res, 3, 4, 5, 6)
  math::equal(Bool, h, Res)
  error + 1-math::all(bool)
  
  math::set(i,a)
  math::let_scalar(i, i, *, 2.0)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, i, Res)
  error + 1-math::all(bool)
  
  math::set(j,b)
  math::let_scalar(j, j, /, 2.0)
  math::set_float(res, 2, 2.5, 3, 3.5)
  math::equal(Bool, j, Res)
  error + 1-math::all(bool)
  
  ; --------
  
  math::add(  C, A,  b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::sub(  D, B, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::mul(  E, A, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::div(  f, B, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  ; -------
  
  math::set(C,A)
  math::add(C,  C, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::set(D,B)
  math::sub(D, D, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::set(E,A)
  math::mul(E,  E, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::set(f,b)
  math::div(f,  f, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  
  ProcedureReturn error  
  
EndProcedure
Procedure.l  Test_Vec4_operators()
  Protected.l error =0
  Protected.math::vec4l Bool
  Protected.math::Vec4 res,a,b,c,d,e,f,g,h,i,j,k,l,m,n
  math::set_float(a, 1.0, 2.0, 3.0, 4.0)
  math::set_float(b, 4.0, 5.0, 6.0, 7.0)
  
  math::let(  C, A, +, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::let(  D, B, -, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::let(  E, A, *, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::let(  f, B, /, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  math::let_scalar(  g, a, +, 1.0)
  math::set_float(res, 2, 3, 4, 5)
  math::equal(Bool, g, Res)
  error + 1-math::all(bool)
  
  math::let_scalar(  h, B, -, 1.0)
  math::set_float(res, 3, 4, 5, 6)
  math::equal(Bool, h, Res)
  error + 1-math::all(bool)
  
  math::let_scalar( i, a, *, 2.0)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, i, Res)
  error + 1-math::all(bool)
  
  math::let_scalar( j, b, /, 2.0)
  math::set_float(res, 2, 2.5, 3, 3.5)
  math::equal(Bool, j, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( k, 1.0, +, a)
  math::set_float(res, 2,3,4,5)
  math::equal(Bool, k, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( l, 1.0, -, b)
  math::set_float(res, -3,-4,-5,-6)
  math::equal(Bool, l, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( m, 2.0, *, a)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, m, Res)
  error + 1-math::all(bool)
  
  math::scalar_let( n, 2.0, /, b)
  math::set_float(res,0.5,2/5,2/6,2/7)
  math::equal(Bool, n, Res)
  error + 1-math::all(bool)
  
  ; --------
  
  math::set(C,A)
  math::let(C, C, +, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::set(D,B)
  math::let(D, D, -, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::set(E,A)
  math::Let(E,  E, *, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::set(f,b)
  math::Let(f,  f, /, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  math::set(g,a)
  math::let_scalar(g, g, +, 1.0)
  math::set_float(res, 2, 3, 4, 5)
  math::equal(Bool, g, Res)
  error + 1-math::all(bool)
  
  math::set(h,b)
  math::let_scalar(h,  h, -, 1.0)
  math::set_float(res, 3, 4, 5, 6)
  math::equal(Bool, h, Res)
  error + 1-math::all(bool)
  
  math::set(i,a)
  math::let_scalar(i, i, *, 2.0)
  math::set_float(res, 2,4,6,8)
  math::equal(Bool, i, Res)
  error + 1-math::all(bool)
  
  math::set(j,b)
  math::let_scalar(j, j, /, 2.0)
  math::set_float(res, 2, 2.5, 3, 3.5)
  math::equal(Bool, j, Res)
  error + 1-math::all(bool)
  
  ; --------
  
  math::add(  C, A,  b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::sub(  D, B, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::mul(  E, A, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::div(  f, B, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  ; -------
  
  math::set(C,A)
  math::add(C,  C, b)
  math::set_float(res, 5,7,9,11)
  math::equal(Bool, C, Res)
  error + 1- math::all(bool)
  
  math::set(D,B)
  math::sub(D, D, A)
  math::set_float(res, 3,3,3,3)
  math::equal(Bool, D, Res)
  error + 1-math::all(bool)
  
  math::set(E,A)
  math::mul(E,  E, b)
  math::set_float(res, 4,10,18,28)
  math::equal(Bool, E, Res)
  error + 1-math::all(bool)
  
  math::set(f,b)
  math::div(f,  f, A)
  math::set_float(res, 4, 2.5, 2, 7/4)
  math::equal(Bool, F, Res)
  error + 1-math::all(bool)
  
  
  ProcedureReturn error  
  
EndProcedure

call(Vec2_operators)
call(Vec3_operators)
call(Vec4_operators)

;- matrix_type -------------------

Macro matAxA(nb)
  Procedure.l  test_mat#nb#_inverse()
    Protected.l error
    Protected.math::mat#nb#x#nb# Identity, Matrix, Inverse,inverse2, Result
    Protected.math::mat#nb#x#nb#L Bool
    Protected.f epsilon = 0.001
    math::set_float(Identity, 1.0)
    
    math::set_float(Matrix, 
                    0.6, 0.2, 0.3, 0.4,
                    0.2, 0.7, 0.5, 0.3,
                    0.3, 0.5, 0.7, 0.2,
                    0.4, 0.3, 0.2, 0.6)
    math::inverse(inverse2, Matrix)
    
    math::div(Inverse, Identity, Matrix)
    math::mul(Result, Matrix, Inverse)
    
    math::equal(bool, Identity, Result, epsilon)
    
    error + 1 - math::all(bool)
    ProcedureReturn error    
  EndProcedure
  call(mat#nb#_inverse)
  
  Procedure.l  test_mat#nb#_operators()
    Protected.f epsilon = 0.001
    Protected.l error
    Protected.math::mat#nb#x#nb M,N,P,Q,O
    Protected.math::vec#nb U,V,W,tmp
    Protected.math::mat#nb#x#nb#L mBool
    Protected.math::vec#nb#L vBool
    
    math::set_float(M, 2.0)
    math::set_float(N, 1.0)
    math::set_float(U, 2.0)
    
    math::let_Scalar(p, N, *, 2.0)
    math::equal(mBool, P, M, epsilon)
    error + 1- math::all(mbool)
    
    math::let_Scalar(q, m, /, 2.0)
    math::equal(mBool, q, n, epsilon)
    error + 1- math::all(mBool)
    
    math::mul(v, m, u)
    math::set_float(tmp,4)
    math::equal(vbool, v, tmp,epsilon)
    error + 1- math::all(vBool)
    ;Debug math::string(v)+" = "+math::string(m)+" * "+math::string(u)
    ;Debug math::String(tmp)
    
    math::div(w,u,m)
    math::set_float(tmp,1)
    math::equal(vBool,w, tmp, epsilon)
    error + 1- math::all(vBool)
    
    math::mul(O,m,n)
    math::equal(mBool,o,m,epsilon)
    error + 1- math::all(mBool)
    
    ProcedureReturn error
    
  EndProcedure
  call(mat#nb#_operators)
  
EndMacro
Macro matAxB(nbA,nbB)
  Procedure.l  test_mat#nba#x#nbb#_operators()
    Protected.math::mat#nba#x#nbb l,m,n,o,p,q
    Protected.math::vec#nba u, b
    Protected.math::vec#nbb v, a
    Protected.math::mat#nba#x#nbb#L Bool
    math::set_float(l, 1)
    math::set_float(m, 1)
    math::set_float(u, 1)
    math::set_float(v, 1)
    Protected.f x = 1.0
    math::mul(a, m, u)
    math::mul(b, v, m)
    math::Scalar_let(n, x, /, m)
    math::let_Scalar(o, m, /, x)
    math::Scalar_let(p, x, *, m)
    math::let_Scalar(q, m, *, x)
    
    math::notEqual(bool, m, q)
    Protected.l r = math::any(bool)
    math::equal(bool, m, l)
    Protected.l s = math::all(bool) 
    
    ProcedureReturn 1-Bool(s And Not r)    
  EndProcedure
  call(mat#nba#x#nbb#_operators)
EndMacro


matAxA(2)
matAxA(3)
matAxA(4)
matAxB(2,2)
matAxB(2,3)
matAxB(2,4)
matAxB(3,2)
matAxB(3,3)
matAxB(3,4)
matAxB(4,2)
matAxB(4,3)
matAxB(4,4)

;-func_matrix -------------------

Macro _matrixCompMult(mxm, e0=0,e1=0,e2=0,e3=0,e4=0,e5=0,e6=0,e7=0,e8=0,e9=0,e10=0,e11=0,e12=0,e13=0,e14=0,e15=0)
  Protected.math::Mat#mxm m#mxm,n#mxm,expected#mxm
  Protected.math::mat#mxm#l bool#mxm
  math::set_float(m#mxm, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
  math::matrixCompMult(n#mxm,m#mxm,m#mxm)
  math::set_float(expected#mxm,e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15)
  math::equal(bool#mxm,n#mxm,expected#mxm)
  error + 1- math::all(bool#mxm)
EndMacro

Procedure.l  test_matrixCompMult()
  Protected.l error
  
  _matrixCompMult(2x2,0,1,4,9,4)
  _matrixCompMult(2x3,0,1,4,9,16,25)
  _matrixCompMult(2x4,0,1,4,9,16,25,36,49)
  _matrixCompMult(3x3,0, 1, 4, 9, 16, 25, 36, 49, 64)
  _matrixCompMult(3x2,0, 1, 4, 9, 16, 25)
  _matrixCompMult(3x4,0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121)
  _matrixCompMult(4x4,0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225)
  _matrixCompMult(4x2,0, 1, 4, 9, 16, 25, 36, 49)
  _matrixCompMult(4x3,0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121)
  
  ProcedureReturn error
EndProcedure


call(matrixCompMult)

Procedure.l  test_outerProduct()
  Protected.l error
  Protected.math::vec3 u
  Protected.math::vec4 v
  
  math::set_float(u, 3,2,1)
  math::set_float(v, 7,2,3,1)
  
  Protected.math::mat4x3 res, expected
  Protected.math::mat4x3L bool
  math::outerProduct(res, u, v)
  math::set_float(expected,21,14,7,6,4,2,9,6,3,3,2,1)
  
  math::equal(bool, res, expected)
  error + 1- math::All(bool)
  
  ProcedureReturn error
EndProcedure

call(outerProduct)

Macro _transpose(a,b,e0=0,e1=0,e2=0,e3=0,e4=0,e5=0,e6=0,e7=0,e8=0,e9=0,e10=0,e11=0,e12=0,e13=0,e14=0,e15=0)
  Protected.math::Mat#a#x#b m#a#b
  Protected.math::mat#b#x#a t#a#b, expected#a#b
  Protected.math::mat#b#x#a#l bool#a#b
  math::set_float(m#a#b, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
  math::transpose(t#a#b, m#a#b)
  math::set_float(expected#a#b,e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15)
  math::equal(bool#a#b,t#a#b,expected#a#b)
  error + 1- math::all(bool#a#b)
EndMacro


Procedure.l  test_transpose()
  Protected.l error
  _transpose(2,2, 0, 2, 1, 3)
  _transpose(2,3, 0, 3, 1, 4, 2, 5)
  _transpose(2,4, 0, 4, 1, 5, 2, 6, 3, 7)
  _transpose(3,3, 0, 3, 6, 1, 4, 7, 2, 5, 8)
  _transpose(3,2, 0, 2, 4, 1, 3, 5)
  _transpose(3,4, 0, 4, 8, 1, 5, 9, 2, 6, 10, 3, 7, 11)
  _transpose(4,4, 0, 4, 8, 12, 1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15)
  _transpose(4,2, 0, 2, 4, 6, 1, 3, 5, 7)
  _transpose(4,3, 0, 3, 6, 9, 1, 4, 7, 10, 2, 5, 8, 11)
  ProcedureReturn error
EndProcedure
call(transpose)

Macro _determinant(expected,nb,e0=0,e1=0,e2=0,e3=0,e4=0,e5=0,e6=0,e7=0,e8=0,e9=0,e10=0,e11=0,e12=0,e13=0,e14=0,e15=0)
  Protected.math::Mat#nb#x#nb m#nb
  math::set_float( m#nb,e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15)
  error + 1-Bool( Abs(math::determinant(m#nb) - (expected)) < math::#epsilon)
EndMacro

Procedure.l  test_determinant()
  Protected.l error
  _determinant(  -2, 2, 1,3, 2,4)
  _determinant(   0, 3, 1,4,7, 2,5,8, 3,6,9)
  _determinant(-376, 4, 1,1,4,5, 3,3,3,2, 5,1,9,0, 9,7,7,9) 
  ProcedureReturn error
EndProcedure
call(determinant)

Procedure.l  test_inverse()
  Protected.l error
  Protected.math::mat4x4 a4,b4,i4,r4
  Protected.math::mat4x4l bool4
  math::set_float(a4, 1,0,1,0, 0,1,0,0, 0,0,1,0, 0,0,0,1)
  math::inverse(b4,a4)
  math::set_float(i4,1)
  math::mul(r4,a4,b4)
  math::equal(bool4,r4,i4)
  error + 1- math::all(bool4)
  
  Protected.math::mat3x3 a3,b3,i3,r3
  Protected.math::mat3x3l bool3
  math::set_float(a3, 1,0,1, 0,1,0, 0,0,1)
  math::inverse(b3,a3)
  math::set_float(i3,1)
  math::mul(r3,a3,b3)
  math::equal(bool3,r3,i3)
  error + 1- math::all(bool3)
  
  Protected.math::mat2x2 a2,b2,i2,r2
  Protected.math::mat2x2l bool2
  math::set_float(a2, 1,1, 0,1)
  math::inverse(b2,a2)
  math::set_float(i2,1)
  math::mul(r2,a2,b2)
  math::equal(bool2,r2,i2)
  error + 1- math::all(bool2)
  
  ProcedureReturn error
EndProcedure
call(inverse)

;- geometric -------------------

Procedure.l  test_length()
  Protected.math::vec2 v2
  Protected.math::Vec3 v3
  Protected.math::vec4 v4
  math::set_float(v2, 1,0)
  math::set_float(v3, 1,0,0)
  math::set_float(v4, 1,0,0,0)
  
  Protected.l error
  
  error + 1-Bool( Abs(math::length(v2) -1.0) < math::#epsilon)
  error + 1-Bool( Abs(math::length(v3) -1.0) < math::#epsilon)
  error + 1-Bool( Abs(math::length(v4) -1.0) < math::#epsilon)
  
  ProcedureReturn error
  
EndProcedure
call(length)

Procedure.l  test_distance()
  Protected.math::vec2 v2,u2
  Protected.math::Vec3 v3,u3
  Protected.math::vec4 v4,u4
  math::set_float(v2, 1,0)
  math::set_float(v3, 1,0,0)
  math::set_float(v4, 1,0,0,0)
  math::set_float(u2, 1,0)
  math::set_float(u3, 1,0,0)
  math::set_float(u4, 1,0,0,0)
  
  Protected.l error
  
  error + 1-Bool( math::distance(v2,u2) < math::#epsilon)
  error + 1-Bool( math::distance(v3,u3) < math::#epsilon)
  error + 1-Bool( math::distance(v4,u4) < math::#epsilon)
  ProcedureReturn error
EndProcedure
call(distance)

Procedure.l  test_dot()
  Protected.math::vec2 v2
  Protected.math::Vec3 v3
  Protected.math::vec4 v4
  math::set_float(v2, 1)
  math::set_float(v3, 1)
  math::set_float(v4, 1)
  
  Protected.l error
  
  error + 1-Bool( Abs(math::dot(v2,v2) -2.0) < math::#epsilon)
  error + 1-Bool( Abs(math::dot(v3,v3) -3.0) < math::#epsilon)
  error + 1-Bool( Abs(math::dot(v4,v4) -4.0) < math::#epsilon)
  ProcedureReturn error
EndProcedure
call(dot)

Procedure.l  test_cross()
  Protected.math::vec3 a1,b1,a2,b2,u,v,cross1,cross2,epsilon
  
  math::set_float(a1, 1,0,0)
  math::set_float(b1, 0,1,0)
  math::set_float(a2, 0,1,0)
  math::set_float(b2, 1,0,0)
  math::set_float(u, 0, 0, 1)
  math::set_float(v, 0, 0,-1)
  math::set_float(epsilon,math::#epsilon)
  
  Protected.l error  
  Protected.math::vec3l bool
  
  math::cross(cross1,a1,b1)
  ;Debug math::vec_string(a1)+" x "+math::vec_string(b1) +" = "+ math::vec_string(cross1)
  math::let(cross1, cross1,-,u)
  math::Abs(cross1,cross1)
  math::lessThan(bool,cross1, epsilon)
  error + 1- math::all(bool)
  
  math::cross(cross2,a2,b2)
  math::let(cross2, cross2,-,v)
  math::Abs(cross2,cross2)
  math::lessThan(bool,cross2, epsilon)
  error + 1- math::all(bool)
  
  ProcedureReturn error
EndProcedure
call(cross)

Procedure.l  test_normalize()
  Protected.math::Vec3 normalize1, normalize2, a,b, epsilon
  Protected.math::vec3l bool
  
  math::set_float(a, 1,0,0)
  math::normalize(normalize1, a)
  math::set_float(b, 2,0,0)
  math::normalize(normalize2, b)
  
  math::set_float(epsilon, math::#epsilon)
  
  Protected.l error
  
  ;Debug math::vec_string(normalize1,8)+" "+math::vec_string(a,8)
  math::sub(normalize1, normalize1, a)
  ;Debug math::vec_string(normalize1,8)
  math::Abs(normalize1, normalize1)
  ;Debug math::vec_string(normalize1,8)
  ;Debug math::vec_string(epsilon,8)
  math::lessThan(bool, normalize1, epsilon)
  error +1-math::all(bool)
  
  
  math::sub(normalize2, normalize2, a)
  math::Abs(normalize2, normalize2)
  math::lessThan(bool, normalize2, epsilon)
  error +1-math::all(bool)
  
  ProcedureReturn error
EndProcedure
call(normalize)

Procedure.l  test_faceforward()
  Protected.l error
  
  Protected.math::vec3 n,i,nref,f,expected
  Protected.math::vec3l bool
  math::set_float(n, 0,0,1)
  math::set_float(i, 1,0,1)
  math::set_float(nref, 0,0,1)
  math::set_float(expected, 0,0,-1)
  
  math::faceforward(f,n,i,nref)
  math::equal(bool, f,expected)
  error + 1- math::all(bool)
  
  ProcedureReturn error
EndProcedure
call(faceforward)

Procedure.l  test_reflect()
  Protected.l error
  
  Protected.math::vec2 a,b,c,expected
  Protected.math::vec2l bool
  math::set_float(a, 1,-1)
  math::set_float(b, 0, 1)
  math::set_float(expected, 1,1)
  
  math::reflect(c,a,b)
  math::equal(bool, c, expected)
  error + 1- math::all(bool)
  
  
  ProcedureReturn error
EndProcedure
call(reflect)

Procedure.l  test_refract()
  Protected.l error
  
  Protected.f af, bf, cf
  af=-1
  bf=1
  cf= math::refract_f(af,bf,0.5)
  error + 1- math::equal_f(cf,-1, 0.0001)
  
  Protected.math::Mat2x2 a,b,c
  Protected.math::mat2x2L bool
  
  math::set_float(a, 0,-1,0,0)
  math::set_float(b, 0, 1,0,0)
  math::refract(c, a,b,0.5)
  math::equal(bool, c, a, 0.0001)
  error +1- math::all(bool)  
  
  ProcedureReturn error
EndProcedure
call(refract)

;-exponential -------------------
Macro _pow(nb, v1,v2, expected, epsilon)
  Protected.math::vec#nb a#nb, b#nb, c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, v1)
  math::set_float(b#nb, v2)
  math::set_float(r#nb, expected)
  math::Pow(c#nb, a#nb, b#nb)
  math::equal(bool#nb, c#nb, r#nb, epsilon)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_pow()
  Protected.l error  
  error +1 - math::equal_f( math::Pow_f(2, 2), 4, 0.01)
  _pow(2, 2,2,4, 0.01)
  _pow(3, 2,2,4, 0.01)
  _pow(4, 2,2,4, 0.01)  
  ProcedureReturn error
EndProcedure
call(pow)

Macro _sqrt(nb, v1, expected, epsilon)
  Protected.math::vec#nb a#nb,c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, v1)
  math::set_float(r#nb, expected)
  math::sqrt(c#nb, a#nb)
  math::equal(bool#nb, c#nb, r#nb, epsilon)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_sqrt()
  Protected.l error  
  error +1 - math::equal_f( math::Sqrt_f(4), 2, 0.01)
  _sqrt(2, 4,2, 0.01)
  _sqrt(3, 4,2, 0.01)
  _sqrt(4, 4,2, 0.01)  
  ProcedureReturn error
EndProcedure
call(sqrt)

Macro _exp(nb, v1, expected, epsilon)
  Protected.math::vec#nb a#nb,c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, v1)
  math::set_float(r#nb, expected)
  math::Exp(c#nb, a#nb)
  math::equal(bool#nb, c#nb, r#nb, epsilon)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_exp()
  Protected.l error  
  error +1 - math::equal_f( math::Exp_f(1), math::#E, 0.01)
  _exp(2, 1,math::#E, 0.01)
  _exp(3, 1,math::#E, 0.01)
  _exp(4, 1,math::#E, 0.01)  
  ProcedureReturn error
EndProcedure
call(exp)

Macro _log(nb, v1, expected, epsilon)
  Protected.math::vec#nb a#nb,c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, v1)
  math::set_float(r#nb, expected)
  math::Log(c#nb, a#nb)
  math::equal(bool#nb, c#nb, r#nb, epsilon)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_log()
  Protected.l error  
  error +1 - math::equal_f( math::Log_f(math::#E), 1, 0.01)
  _log(2, math::#E,1, 0.01)
  _log(3, math::#E,1, 0.01)
  _log(4, math::#E,1, 0.01)  
  ProcedureReturn error
EndProcedure
call(log)


Macro _exp2(nb, e1,e2,e3,e4, epsilon)
  Protected.math::vec#nb a#nb,c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, 4,3,2,1)
  math::set_float(r#nb, e1,e2,e3,e4)
  math::exp2(c#nb, a#nb)
  math::equal(bool#nb, c#nb, r#nb, epsilon)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_exp2()
  Protected.l error  
  error +1 - math::equal_f( math::Exp2_f(4), 16, 0.01)
  _exp2(2, 16,8,0,0, 0.01)
  _exp2(3, 16,8,4,0, 0.01)
  _exp2(4, 16,8,4,2, 0.01)  
  ProcedureReturn error
EndProcedure
call(exp2)

Macro _log2(nb, e1,e2,e3,e4, epsilon)
  Protected.math::vec#nb a#nb,c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, 16,8,4,2)
  math::set_float(r#nb, e1,e2,e3,e4)
  math::log2(c#nb, a#nb)
  math::equal(bool#nb, c#nb, r#nb, epsilon)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_log2()
  Protected.l error  
  error +1 - math::equal_f( math::log2_f(16), 4, 0.01)
  _log2(2, 4,3,0,0, 0.01)
  _log2(3, 4,3,2,0, 0.01)
  _log2(4, 4,3,2,1, 0.01)  
  ProcedureReturn error
EndProcedure
call(log2)

Macro _inversesqrt(nb)
  Protected.math::vec#nb a#nb,b#nb,c#nb, r#nb
  Protected.math::vec#nb#l bool#nb
  math::set_float(a#nb, 16)
  math::set_float(b#nb, 16)
  math::inversesqrt(a#nb, a#nb)
  math::sqrt(b#nb, b#nb)
  math::mul(c#nb, a#nb, b#nb)
  math::set_float(r#nb, 1)  
  ;Debug math::string(a#nb)+" * "+math::string(b#nb)+" = "+math::string(c#nb)
  math::equal(bool#nb, c#nb, r#nb, 0.01)
  error+ 1-math::all(bool#nb)
EndMacro

Procedure.l  test_inversesqrt()
  Protected.l error  
  error +1 - math::equal_f( math::inversesqrt_f(16) * math::sqrt_F(16), 1, 0.01)
  _inversesqrt(2)
  _inversesqrt(3)
  _inversesqrt(4)
  ProcedureReturn error
EndProcedure
call(inversesqrt)

;- vector relation -------------------
Procedure.l  test_not()
  Protected.l error
  
  Protected.math::vec2l a2,bool2
  math::bool_not(bool2,a2)
  error + 1- math::all(bool2)
  
  Protected.math::vec3l a3,bool3
  math::bool_not(bool3,a3)
  error + 1- math::all(bool3)
  
  Protected.math::vec4l a4,bool4
  math::bool_not(bool4,a4)
  error + 1- math::all(bool4)
  
  ProcedureReturn error
EndProcedure
call(Not)

Macro _less(nb)
  Protected.math::vec#nb a#nb,b#nb
  Protected.math::vec#nb#l Bool#nb
  math::set_float(a#nb, 1,2,3,4)
  math::set_float(b#nb, 2,3,4,5)
  math::lessThan(bool#nb, a#nb,b#nb)
  error + 1- math::all(bool#nb)
  math::lessThanEqual(bool#nb, a#nb,b#nb)
  error + 1- math::all(bool#nb)
EndMacro

Procedure.l  test_less()
  Protected.l error
  
  _less(2)
  _less(3)
  _less(4) 
  
  ProcedureReturn error
EndProcedure
call(less)

Macro _greater(nb)
  Protected.math::vec#nb a#nb,b#nb
  Protected.math::vec#nb#l Bool#nb
  math::set_float(a#nb, 1,2,3,4)
  math::set_float(b#nb, 2,3,4,5)
  math::greaterThan(bool#nb, b#nb,a#nb)
  error + 1- math::all(bool#nb)
  math::greaterThanEqual(bool#nb, b#nb,a#nb)
  error + 1- math::all(bool#nb)
EndMacro

Procedure.l  test_greater()
  Protected.l error
  
  _greater(2)
  _greater(3)
  _greater(4) 
  
  ProcedureReturn error
EndProcedure
call(greater)

Macro _equal(nb)
  Protected.math::vec#nb a#nb,b#nb
  Protected.math::vec#nb#l Bool#nb
  math::set_float(a#nb, 1,2,3,4)
  math::set_float(b#nb, 1,2,3,4)
  math::equal(bool#nb, b#nb,a#nb)
  error + 1- math::all(bool#nb)
  math::greaterThanEqual(bool#nb, b#nb,a#nb)
  error + 1- math::all(bool#nb)
  math::lessThanEqual(bool#nb, b#nb,a#nb)
  error + 1- math::all(bool#nb)
EndMacro

Procedure.l  test_equal()
  Protected.l error
  
  _equal(2)
  _equal(3)
  _equal(4) 
  
  ProcedureReturn error
EndProcedure
call(equal)

;- common -------------------

Macro _common(nb)
  Protected.math::vec#nb a#nb, b#nb, c#nb, r#nb, e#nb, one#nb, i#nb, two#nb, zero#nb, nOne#nb
  Protected.math::vec#nb#l bool#nb  
  math::set_float(one#nb,1)
  math::set_float(nOne#nb,-1)
  math::set_float(two#nb,2)
  math::set_float(zero#nb,0)
  
  ;floor
  math::set_float(a#nb, 1.1)
  math::floor(r#nb, a#nb)
  math::equal(bool#nb, r#nb, one#nb, 0.0001)
  error +1- math::all(bool#nb)
  ;Debug "a"+error
  
  math::set_float(a#nb, 1.9)
  math::floor(r#nb, a#nb)
  math::equal(bool#nb, r#nb, one#nb, 0.0001)
  error +1- math::all(bool#nb)
  ;Debug "b"+error
  
  ;modf
  math::set_float(a#nb, 1.1, 1.2, 1.5, 1.7)
  math::set_float(e#nb, 0.1, 0.2, 0.5, 0.7)
  math::modf(r#nb, a#nb, i#nb)
  math::equal(bool#nb, r#nb, e#nb, 0.0001)
  error +1- math::all(bool#nb)
  math::equal(bool#nb, i#nb, one#nb, 0.0001)
  error +1- math::all(bool#nb)
  ;Debug "c"+error
  
  ;mod
  math::set_float(a#nb, 3)
  math::mod_Scalar(r#nb, a#nb, 2)
  math::equal(bool#nb, r#nb, one#nb, 0.00001)
  error +1- math::all(bool#nb)
  math::set_float(b#nb, 2)
  math::Mod(r#nb, a#nb, b#nb)
  error +1- math::all(bool#nb)
  ;Debug "d"+error
  
  ;min
  math::min(r#nb, one#nb, two#nb)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  math::min_Scalar(r#nb, two#nb, 1.0)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  ;Debug "e"+error
  
  ;max
  math::max(r#nb, one#nb, zero#nb)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  math::max_Scalar(r#nb, zero#nb, 1.0)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  ;Debug "f"+error
  
  ;clamp
  math::clamp_Scalar(r#nb, two#nb, 0, 1)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  math::clamp_Scalar(r#nb, zero#nb, 1, 2)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  ;Debug "g"+error
  
  ;mix
  math::mix_scalar(r#nb, zero#nb, one#nb, #False)
  math::equal(bool#nb, r#nb, zero#nb)
  error +1- math::all(bool#nb)
  ;Debug "h"+error+" "+math::string(zero#nb)+" "+math::string(one#nb)+" r"+math::string(r#nb)+" f"+#False
  
  math::mix_scalar(r#nb, zero#nb, one#nb, #True)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  ;Debug "i"+error+" "+math::string(zero#nb)+" "+math::string(one#nb)+" r"+math::string(r#nb)+" f"+#True
  
  math::mix(r#nb, zero#nb, one#nb, zero#nb)
  math::equal(bool#nb, r#nb, zero#nb)
  error +1- math::all(bool#nb)
  ;Debug "j"+error+" "+math::string(zero#nb)+" "+math::string(one#nb)+" r"+math::string(r#nb)+" f"+math::String(zero#nb)
  
  math::mix(r#nb, zero#nb, one#nb, one#nb)
  math::equal(bool#nb, r#nb, one#nb)
  error +1- math::all(bool#nb)
  ;Debug "k"+error+" "+math::string(zero#nb)+" "+math::string(one#nb)+" r"+math::string(r#nb)+" f"+math::String(one#nb)
  
  ;nan
  math::div(r#nb, zero#nb, zero#nb)
  math::IsNAN(bool#nb, r#nb)
  error +1- math::all(bool#nb)
  ;Debug "l"+error
  
  ;inf
  math::div(r#nb, one#nb, zero#nb)
  math::isInf(bool#nb, r#nb)
  error +1- math::all(bool#nb)
  math::div(r#nb, nOne#nb, zero#nb)
  math::isInf(bool#nb, r#nb)
  error +1- math::all(bool#nb)
  ;Debug "m"+error
  
  ;frexp
  math::set_float(a#nb, 1024, 0.24,   0,  -1.33)
  math::set_float(e#nb,  0.5, 0.96, 0.0, -0.665)
  math::set_float(i#nb,   11,   -2,   0,      1)
  math::frexp(r#nb, a#nb, c#nb)
  math::equal(bool#nb, r#nb, e#nb)  
  ;Debug ""+error
  error +1- math::all(bool#nb)
  ;Debug ""+error+" "+ math::string(r#nb)+" "+math::string(e#nb)
  math::equal(bool#nb, c#nb, i#nb)
  ;Debug ""+error+" "+ math::string(c#nb)+" "+math::string(i#nb)
  error +1- math::all(bool#nb)
  ;Debug "--"
  ;Debug "n"+error
  
  ;ldexp
  math::set_float(a#nb, 0.5,0.96,0.0,-0.665)
  math::set_float(b#nb, 11,-2,0,1)
  math::set_float(e#nb, 1024,0.24,0,-1.33)
  math::ldexp(r#nb, a#nb, b#nb)
  math::equal(bool#nb, r#nb, e#nb)
  error +1- math::all(bool#nb)
  ;Debug "o"+error
  
EndMacro

Procedure.l test_common()
  Protected.l error
  Protected.f f
  error + 1- math::equal_f( math::Floor_f(1.1) , 1, 0.0001)
  
  error + 1- math::equal_f( math::modf_f(1.5,@f), 0.5, 0.0001)
  error + 1- math::equal_f( f, 1.0, 0.0001)
  
  error + 1- math::equal_f( math::Mod_f( 1.5,1.0) , 0.5, 0.00001)
  error + 1- math::equal_f( math::Mod_f(-0.2,1.0) , 0.8, 0.00001)
  error + 1- math::equal_f( math::Mod_f( 3.0,2.0) , 1.0, 0.00001)
  
  error + 1- math::equal_f( math::min_f(1,2) , 1)
  error + 1- math::equal_f( math::max_F(1,0) , 1)
  
  error + 1- math::equal_f( math::clamp_f(2,0,1) , 1)
  error + 1- math::equal_f( math::clamp_f(0,1,2) , 1)
  
  error + 1- math::equal_f( math::mix_f(0,1,#False) , 0)
  error + 1- math::equal_f( math::mix_f(0,1,#True) , 1)
  
  ;round
  error + 1- math::equal_f( math::Round_f( 0.0) , 0.0)
  error + 1- math::equal_f( math::Round_f( 0.5) , 1.0)
  error + 1- math::equal_f( math::Round_f( 1.0) , 1.0)
  error + 1- math::equal_f( math::Round_f( 0.1) , 0.0)
  error + 1- math::equal_f( math::Round_f( 0.9) , 1.0)
  error + 1- math::equal_f( math::Round_f( 1.5) , 2.0)
  error + 1- math::equal_f( math::Round_f( 1.9) , 2.0)
  
  error + 1- math::equal_f( math::Round_f( -0.0) ,  0.0)
  error + 1- math::equal_f( math::Round_f( -0.5) , -1.0)
  error + 1- math::equal_f( math::Round_f( -1.0) , -1.0)
  error + 1- math::equal_f( math::Round_f( -0.1) ,  0.0)
  error + 1- math::equal_f( math::Round_f( -0.9) , -1.0)
  error + 1- math::equal_f( math::Round_f( -1.5) , -2.0)
  error + 1- math::equal_f( math::Round_f( -1.9) , -2.0)
  
  ;roundeven
  error + 1- math::equal_f( math::roundEven_f( -1.5) , -2.0)
  error + 1- math::equal_f( math::roundEven_f(  1.5) ,  2.0)
  error + 1- math::equal_f( math::roundEven_f( -2.5) , -2.0)
  error + 1- math::equal_f( math::roundEven_f(  2.5) ,  2.0)
  error + 1- math::equal_f( math::roundEven_f( -3.5) , -4.0)
  error + 1- math::equal_f( math::roundEven_f( -4.5) , -4.0)
  error + 1- math::equal_f( math::roundEven_f(  4.5) ,  4.0)
  error + 1- math::equal_f( math::roundEven_f( -5.5) , -6.0)
  error + 1- math::equal_f( math::roundEven_f(  5.5) ,  6.0)
  error + 1- math::equal_f( math::roundEven_f( -7.5) , -8.0)
  error + 1- math::equal_f( math::roundEven_f(  7.5) ,  8.0)
  
  error + 1- math::equal_f( math::roundEven_f( -2.4) , -2.0)
  error + 1- math::equal_f( math::roundEven_f(  2.4) ,  2.0)
  error + 1- math::equal_f( math::roundEven_f( -2.6) , -3.0)
  error + 1- math::equal_f( math::roundEven_f(  2.6) ,  3.0)
  error + 1- math::equal_f( math::roundEven_f( -2.0) , -2.0)
  error + 1- math::equal_f( math::roundEven_f(  2.0) ,  2.0)
  
  error + 1- math::equal_f( math::roundEven_f(  0.0) ,  0.0)
  error + 1- math::equal_f( math::roundEven_f(  0.5) ,  0.0)
  error + 1- math::equal_f( math::roundEven_f(  1.0) ,  1.0)
  error + 1- math::equal_f( math::roundEven_f(  0.1) ,  0.0)
  error + 1- math::equal_f( math::roundEven_f(  0.9) ,  1.0)
  error + 1- math::equal_f( math::roundEven_f(  1.5) ,  2.0)
  error + 1- math::equal_f( math::roundEven_f(  1.9) ,  2.0)
  
  error + 1- math::equal_f( math::roundEven_f(  0.0) ,  0.0)
  error + 1- math::equal_f( math::roundEven_f( -0.5) ,  0.0)
  error + 1- math::equal_f( math::roundEven_f( -1.0) , -1.0)
  error + 1- math::equal_f( math::roundEven_f( -0.1) ,  0.0)
  error + 1- math::equal_f( math::roundEven_f( -0.9) , -1.0)
  error + 1- math::equal_f( math::roundEven_f( -1.5) , -2.0)
  error + 1- math::equal_f( math::roundEven_f( -1.9) , -2.0)
  
  error + 1- math::equal_f( math::roundEven_f(  1.5) ,  2.0)
  error + 1- math::equal_f( math::roundEven_f(  2.5) ,  2.0)
  error + 1- math::equal_f( math::roundEven_f(  3.5) ,  4.0)
  error + 1- math::equal_f( math::roundEven_f(  4.5) ,  4.0)
  error + 1- math::equal_f( math::roundEven_f(  5.5) ,  6.0)
  error + 1- math::equal_f( math::roundEven_f(  6.5) ,  6.0)
  error + 1- math::equal_f( math::roundEven_f(  7.5) ,  8.0)
  
  error + 1- math::equal_f( math::roundEven_f( -1.5) , -2.0)
  error + 1- math::equal_f( math::roundEven_f( -2.5) , -2.0)
  error + 1- math::equal_f( math::roundEven_f( -3.5) , -4.0)
  error + 1- math::equal_f( math::roundEven_f( -4.5) , -4.0)
  error + 1- math::equal_f( math::roundEven_f( -5.5) , -6.0)
  error + 1- math::equal_f( math::roundEven_f( -6.5) , -6.0)
  error + 1- math::equal_f( math::roundEven_f( -7.5) , -8.0)
  
  _common(2)
  _common(3)
  _common(4)
  
  ;step
  math::set_float(a4, 1, 2, 3, 4)
  math::set_float(b4, -1, -2, -3, -4)
  
  math::vec_step_Scalar(r4, 1.0, a4)
  math::equal(bool4, r4, one4)
  error +1- math::all(bool4)
  math::vec_step_Scalar(r4, 0.0, a4)
  math::equal(bool4, r4, one4)
  error +1- math::all(bool4)
  math::vec_step_Scalar(r4, 0.0, b4)
  math::equal(bool4, r4, zero4)
  error +1- math::all(bool4)
  
  math::set_float(a4, -1,-2,-3,-4)
  math::set_float(b4, -2,-3,-4,-5)
  math::vec_step(r4, a4, b4)
  math::equal(bool4, r4, zero4)
  error +1- math::all(bool4)
  math::set_float(a4, 0,1,2,3)
  math::set_float(b4, 1,2,3,4)
  math::vec_step(r4, a4, b4)
  math::equal(bool4, r4, one4)
  error +1- math::all(bool4)
  math::set_float(a4, 2,3,4,5)
  math::set_float(b4, 1,2,3,4)
  math::vec_step(r4, a4, b4)
  math::equal(bool4, r4, zero4)
  error +1- math::all(bool4)
  math::set_float(a4, 0,1,2,3)
  math::set_float(b4, -1,-2,-3,-4)
  math::vec_step(r4, a4, b4)
  math::equal(bool4, r4, zero4)
  error +1- math::all(bool4)
  
  ProcedureReturn error  
EndProcedure
call(common)

;- trigonometric  -------------------
Procedure.l test_trigonometric()
  Protected.l error
  
  ProcedureReturn error
EndProcedure
call(trigonometric)

;- matrix_clip_space  -------------------
Procedure.l test_matrix_clip_space()
  Protected.l error
  
  ProcedureReturn error
EndProcedure
call(matrix_clip_space)

;- matrix_common  -------------------
Procedure.l test_matrix_common()
  Protected.l error
  
  Protected.math::mat4x4 a, b, c, e, boolf
  Protected.math::mat4x4l bool
  math::set_float(a, 2)
  math::set_float(b, 4)
  math::set_float(e, 3)
  math::mix_scalar(c, a, b, 0.5)
  math::equal(bool, c, e)  
  
  ProcedureReturn error
EndProcedure
call(matrix_common)

;- matrix_projection  -------------------
Procedure.l test_matrix_projection()
  Protected.l error
  
  ProcedureReturn error
EndProcedure
call(matrix_projection)

;- matrix_transform  -------------------
Procedure.l test_matrix_transform()
  Protected.l error
  
  Protected.math::mat4x4 m,e,t,s,r,one
  Protected.math::vec3 v
  Protected.math::vec4 a,b,e4
  Protected.math::mat4x4l bool
  Protected.math::vec4 bool4
  
  math::set_float(one,1)
  
  ;translate
  math::set_float(m,1)
  math::set_float(v,1)
  math::set_float(e, 
                  1.00, 0.00, 0.00, 0.00, 
                  0.00, 1.00, 0.00, 0.00, 
                  0.00, 0.00, 1.00, 0.00, 
                  1.00, 1.00, 1.00, 1.00)
  math::translate(t, m,v)  
  math::equal(bool, t, e)
  error + 1- math::all(bool)
  
  ;scale
  math::set_float(m,1)
  math::set_float(v,2)
  math::set_float(e, 
                  2, 0, 0, 0,
                  0, 2, 0, 0,
                  0, 0, 2, 0,
                  0, 0, 0, 1)
  math::scale(s, m, v)
  math::equal(bool, s, e)
  error + 1- math::all(bool)
  
  ;rotate
  math::set_float(A, 1.0, 0.0, 0.0, 1.0)  
  math::set_float(V, 0, 0, 1)
  math::set_float(e4, 0.0, 1.0, 0.0, 1.0)
  
  math::rotate(R, one, Radian(90), V)
  math::mul( B, R, A)
  math::equal(bool4, B, E4, 0.0001)
  error + 1- math::all(bool4)
  ;   Debug math::string(b,4)+" = "+math::string(r)+" * "+math::string(a)
  ;   Debug math::String(e4,4)
  ;   Debug math::stringBool(bool4)
  
  
  
  ProcedureReturn error
EndProcedure
call(matrix_transform)


;- ext_quaternion_type  -------------------
Procedure.l test_ext_quaternion_type()
  Protected.l error
  
  Protected.math::vec3 v100, v010, v001, vm100, v0m10, v00m1
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  
  Protected.math::vec3 v1,v2,v3,v4,v5
  Protected.math::vec3l bool
  Protected.math::quat q1,q2,q3,q4,q5
  
  math::set(q1, v100, v010)
  math::mul(v1, q1, v100)
  math::equal(bool, v1, v010, 0.0001)
  error + 1 - math::all(bool)
  
  math::mul(q2, q1, q1)
  math::mul(v2, q2, v100)
  math::equal(bool, v2, vm100, 0.0001)
  error + 1 - math::all(bool)
  
  math::set(q3, v100, vm100)
  math::mul(v3, q3, v100)
  math::equal(bool, v3, vm100, 0.0001)
  error + 1 - math::all(bool)
  
  math::set(q4, v010, v0m10)
  math::mul(v4, q4, v010)
  math::equal(bool, v4, v0m10, 0.0001)
  error + 1 - math::all(bool)
  
  math::set(q5, v001, v00m1)
  math::mul(v5, q5, v001)
  math::equal(bool, v5, v00m1, 0.0001)
  error + 1 - math::all(bool)
  
  ProcedureReturn error
EndProcedure
call(ext_quaternion_type)

;- quaternion_common  -------------------
Procedure.l test_quaternion_common()
  Protected.l error
  
  Protected.math::vec3 v100, v010, v001, vm100, v0m10, v00m1
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  Protected.math::QuatL bool
  Protected.f f3,f4
  
  Protected.math::quat a,b,c,q1,q2,q3,q4
  
  ;conjugate
  math::set(a, v100, v010)
  math::conjugate(c, a)
  math::notEqual(bool, a,c)
  error +1- math::any(bool)  
  math::conjugate(b, c)
  math::equal(bool, a,b)
  error +1- math::all(bool)
  
  ;mix
  math::set(q1, v100, v100)
  math::set(q2, v100, v010)  
  math::mix_Scalar(q3, q1,q2, 0.5)
  f3 = Degree( math::angle(q3) )
  error +1- math::equal_f(f3, 45, 0.001)
  
  math::mix_Scalar(q4, q2,q1, 0.5)
  f4 = Degree( math::angle(q4) )
  error +1- math::equal_f(f4, 45, 0.001)
  
  math::slerp(q3, q1,q2, 0.5)
  f3 = Degree( math::angle(q3) )
  error +1- math::equal_f(f3, 45, 0.001)
  
  math::slerp(q4, q2,q1, 0.5)
  f4 = Degree( math::angle(q4) )
  error +1- math::equal_f(f4, 45, 0.001)
  
  ProcedureReturn error
EndProcedure
call(quaternion_common)

;- quaternion_exponential  -------------------
Procedure.l test_quaternion_exponential()
  Protected.l error
  
  Protected.math::vec3 v100, v010, v001, vm100, v0m10, v00m1
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  Protected.math::QuatL bool
  Protected.f f3,f4
  
  Protected.math::quat q,p,r,u
  
  ;log
  math::set(q, v100, v010)
  math::Log(p, q)
  math::notEqual(bool, q, p, 0.001)
  error +1- math::any(bool)
  
  math::Exp(r, p)
  math::equal(bool, q, r, 0.001)
  error +1 - math::all(bool)
  
  ;pow
  math::set(q, v100, v010)
  math::Pow(p, q,1)
  math::equal(bool, q,p,0.001)
  error +1 - math::all(bool)
  
  math::Pow(p, q,2)
  math::mul(r, q,q)
  math::equal(bool, p,r,0.001)
  error +1 - math::all(bool)
  
  math::sqrt(u, p)
  math::equal (bool, q,u,0.001)
  error +1 - math::all(bool)
  
  ProcedureReturn error
EndProcedure
call(quaternion_exponential)

;- quaternion_geometric  -------------------
Procedure.l test_quaternion_geometric()
  Protected.l error
  
  Protected.math::vec3 v000, v100, v010, v001, vm100, v0m10, v00m1
  math::set_float(v000, 0,0,0)
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  Protected.math::QuatL bool
  Protected.f a
  
  Protected.math::quat q,p,r,u,n
  
  ;length
  math::set_float(q, 1,0,0,0)
  a = math::length( q)
  error + 1- math::equal_f(a, 1.0, 0.001)
  
  math::quat_set_f_vec3(q, 1, v000)
  a = math::length( q)
  error + 1- math::equal_f(a, 1.0, 0.001)
  
  math::set(q, v100, v010)
  a = math::length( q)
  error + 1- math::equal_f(a, 1.0, 0.001)
  
  ;normalize
  math::set_float(q, 1,0,0,0)
  math::normalize(n, q)
  math::equal(bool, q,n,  0.001)
  error +1- math::all(bool)
  
  math::quat_set_f_vec3(q, 1, v000)
  math::normalize(n,q)
  math::equal(bool, q,n,  0.001)
  error +1- math::all(bool)
  
  ;dot
  math::set_float(q, 1,0,0,0)
  math::set_float(p, 1,0,0,0)
  a = math::dot(q,p)
  error +1- math::equal_f(a, 1.0, 0.001)
  
  ProcedureReturn error
EndProcedure
call(quaternion_geometric)

;- quaternion_transform  -------------------
Procedure.l test_quaternion_transform()
  Protected.l error
  
  Protected.math::vec3 v000, v100, v010, v001, vm100, v0m10, v00m1, eye, center, up, v1,v2
  math::set_float(v000, 0,0,0)
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  Protected.math::QuatL bool
  Protected.f a
  Protected.math::mat4x4 m
  
  Protected.math::quat q,p,r,u,n
  
  math::set_float(eye, 0)
  math::set_float(center, 1.1, -2.0, 3.1416)
  math::set_float(up, -0.17, 7.23, -1.744)
  
  ;glm::quat test_quat = glm::quatLookAt(glm::normalize(center - eye), up);
  math::sub(v1, center, eye)
  math::normalize(v1,v1)
  math::LookAt(q, v1, up)
  ;glm::quat test_mat = glm::conjugate(glm::quat_cast(glm::lookAt(eye, center, up)));
  math::LookAt(m, eye, center, up)
  math::set(p, m)
  math::conjugate(p,p)
  
  a = Abs( math::length(q) )
  error +1- math::equal_f(a, 1.0)
  
  ;glm::min(glm::length(test_quat + (-test_mat)), glm::length(test_quat + test_mat))
  math::sub(r, q, p)
  math::add(u, q, p)
  a= math::min_f( math::length(r), math::length(u) )
  error +1- math::equal_f(a, 0.0)
  
  ProcedureReturn error
EndProcedure
call(quaternion_transform)

;- quaternion_trigonometric  -------------------
Procedure.l test_quaternion_trigonometric()
  Protected.l error
  
  Protected.math::vec3 v000, v100, v010, v001, vm100, v0m10, v00m1
  math::set_float(v000, 0,0,0)
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  Protected.math::QuatL bool
  Protected.f a
  Protected.math::mat4x4 m
  
  Protected.math::quat q,p,r,u,n
  
  math::set(q, v100, v010)
  a = Degree( math::angle(q) )
  error +1- math::equal_f(a, 90, 0.001)
  
  math::set(q, v010, v100)
  a = Degree( math::angle(q) )
  error +1- math::equal_f(a, 90, 0.001)
  
  math::angleAxis(q, math::#two_pi -1, v100)
  a =  math::angle(q) 
  error +1- math::notequal_f(a, 1, 0.001)
  
  ProcedureReturn error
EndProcedure
call(quaternion_trigonometric)

;- scalar_reciprocal  -------------------
Procedure.l test_scalar_reciprocal()
  Protected.l error
  Protected.f a,b,c,d
  
  error +1-  math::equal_f(math::sec_f(0.0), 1.0, 0.01) 
  error +1-  math::equal_f(math::sec_f(#PI * 2.0), 1.0, 0.01) 
  error +1-  math::equal_f(math::sec_f(#PI * -2.0), 1.0, 0.01) 
  error +1-  math::equal_f(math::sec_f(#PI * 1.0), -1.0, 0.01) 
  error +1-  math::equal_f(math::sec_f(#PI * -1.0), -1.0, 0.01) 
  
  a = math::csc_f(#PI * 0.5) 
  error +1-  math::equal_f(a, 1.0, 0.01) 
  b = math::csc_f(#PI * -0.5) 
  error +1-  math::equal_f(b, -1.0, 0.01) 
  
  a = math::cot_f(#PI * 0.5) 
  error +1-  math::equal_f(a, 0.0, 0.01) 
  b = math::cot_f(#PI * -0.5) 
  error +1-  math::equal_f(b, 0.0, 0.01) 
  
  error +1-  math::equal_f(math::asec_f(100000.0), #PI * 0.5, 0.01) 
  error +1-  math::equal_f(math::asec_f(-100000.0), #PI * 0.5, 0.01) 
  
  error +1-  math::equal_f(math::acsc_f(100000.0), 0.0, 0.01) 
  error +1-  math::equal_f(math::acsc_f(-100000.0), 0.0, 0.01) 
  
  error +1-  math::equal_f(math::acot_f(100000.0), 0.0, 0.01) 
  error +1-  math::equal_f(math::acot_f(-100000.0), #PI, 0.01) 
  error +1-  math::equal_f(math::acot_f(0.0), #PI * 0.5, 0.01) 
  
  error +1-  math::equal_f(math::sech_f(100000.0), 0.0, 0.01) 
  error +1-  math::equal_f(math::sech_f(-100000.0), 0.0, 0.01) 
  error +1-  math::equal_f(math::sech_f(0.0), 1.0, 0.01) 
  
  error +1-  math::equal_f(math::csch_f(100000.0), 0.0, 0.01) 
  error +1-  math::equal_f(math::csch_f(-100000.0), 0.0, 0.01) 
  
  a = math::coth_f(100.0) 
  error +1-  math::equal_f(a, 1.0, 0.01) 
  
  b = math::coth_f(-100.0) 
  error +1-  math::equal_f(b, -1.0, 0.01) 
  
  a = math::asech_f(1.0) 
  error +1-  math::equal_f(a, 0.0, 0.01) 
  
  error +1-  Bool(math::acsch_f(0.01) > 1.0 )
  error +1-  Bool(math::acsch_f(-0.01) < -1.0 )
  
  error +1-  math::equal_f(math::acsch_f(100.0), 0.0, 0.01) 
  error +1-  math::equal_f(math::acsch_f(-100.0), 0.0, 0.01) 
  
  a = math::acoth_f(1.00001) 
  error +1-  Bool(a > 6.0 )
  
  b = math::acoth_f(-1.00001) 
  error +1-  Bool(b < -6.0 )
  
  c = math::acoth_f(10000.0) 
  error +1-  math::equal_f(c, 0.0, 0.01) 
  
  d = math::acoth_f(-10000.0) 
  error +1-  math::equal_f(d, 0.0, 0.01) 
  
  
  ProcedureReturn error
EndProcedure
call(scalar_reciprocal)

;- gtc_quaternion  -------------------
Procedure.l test_gtc_quaternion()
  Protected.l error
  
  Protected.math::vec3 v000, v100, v010, v001, vm100, v0m10, v00m1, v, v011, v123, v002,v1,v2,u,w
  math::set_float(v000, 0,0,0)
  math::set_float(v100, 1,0,0)
  math::set_float(v010, 0,1,0)
  math::set_float(v001, 0,0,1)
  math::set_float(vm100, -1,0,0)
  math::set_float(v0m10, 0,-1,0)
  math::set_float(v00m1, 0,0,-1)
  math::set_float(v011, 0,1,1)
  math::set_float(v123, 1,2,3)
  math::set_float(v002, 0,0,2)
  Protected.math::QuatL bool
  Protected.math::vec3L bool3
  Protected.f l,a, roll, pitch, yaw
  Protected.math::mat4x4 m
  
  Protected.math::quat n,q,q1,q2,q3,q4
  
  ;quat_angle
  math::angleAxis(q, #PI * 0.25, v001)
  math::normalize(n, q)
  l = math::length(n)
  error +1- math::equal_f(l, 1.0, 0.01)
  a = math::angle(n)
  error +1- math::Equal_f(a, #PI*0.25, 0.01)
  
  math::normalize(v, v011)
  math::angleAxis(q, #PI * 0.25, v)
  math::normalize(n, q)
  l = math::length(n)
  error +1- math::equal_f(l, 1.0, 0.01)
  a = math::angle(n)
  error +1- math::Equal_f(a, #PI*0.25, 0.01)
  
  math::normalize(v, v123)
  math::angleAxis(q, #PI * 0.25, v)
  math::normalize(n, q)
  l = math::length(n)
  error +1- math::equal_f(l, 1.0, 0.01)
  a = math::angle(n)
  error +1- math::Equal_f(a, #PI*0.25, 0.01)
  
  ;angleaxis
  math::angleAxis(q1,0,v001)
  math::angleAxis(q2, #PI*0.5, v001)
  math::mix_Scalar(q3, q1,q2,0.5)
  math::angleAxis(q4, #PI*0.25, v001)
  
  math::equal(bool, q3,q4, 0.01)
  error +1- math::all(bool)
  
  ;normalize
  math::angleAxis(q, #PI*0.25, v001)
  math::normalize(n, q)
  l= math::length(N)
  error +1- math::equal_f(l, 1.0, 0.000001)
  
  math::angleAxis(q, #PI*0.25, v002)
  math::normalize(n, q)
  l= math::length(N)
  error +1- math::equal_f(l, 1.0, 0.000001)
  
  math::angleAxis(q, #PI*0.25, v123)
  math::normalize(n, q)
  l= math::length(N)
  error +1- math::equal_f(l, 1.0, 0.000001)
  
  ;euler
  math::set_float(q, 1,0,0,1)
  roll = math::Roll(q)
  pitch = math::Pitch(q)
  yaw = math::Yaw(q)
  
  math::eulerAngles(v1,q)
  math::set_float(v2, pitch , yaw, roll)
  
  error +1 - math::all_equal(v1,v2, 0.000001)
  
  ;slerp
  Protected.math::quat id,Y90rot,Y180rot, id2,id3,Y90rot2,Y45rot1,Ym45rot2,Y45rot3,Y45rot4,Y90rot3,XZ90rot,almostid,Y90rot4,Ym45rot3
  Protected.f sqrt2, Y45angle3, XZ90angle
  sqrt2 = Sqr(2.0)/2.0
  math::set_float(id, 1,0,0,0)
  math::set_float(Y90rot, sqrt2, 0.0, sqrt2, 0.0)
  math::set_float(Y180rot, 0.0, 0.0, 1.0, 0.0)
  
  math::slerp(id2, id, y90rot, 0)
  error +1- math::all_equal(id, id2, 0.0001)
  
  math::slerp(y90rot2, id, y90rot, 1.0)
  error +1- math::all_equal(y90rot, y90rot2, 0.0001)
  
  math::slerp(y45rot1, id, y90rot, 0.5)
  math::slerp(ym45rot2, y90rot, id, 0.5)
  math::scalar_let(q, 0,-,y90rot)
  math::slerp(Y45rot3, id, q, 0.5)
  Y45angle3 = math::angle(y45rot3)
  error +1- math::equal_f(y45angle3, #PI*0.25, 0.0001)
  error +1- math::all_equal(Ym45rot2, y45rot3, 0.0001)
  
  math::scalar_let(q, 0,-,y90rot)
  math::slerp(y45rot4, q, id, 0.5)
  math::scalar_let(q, 0,-,Y45rot4)
  error +1- math::all_equal(Ym45rot2, q, 0.0001)
  
  math::slerp(y90rot3, y90rot, y90rot, 0.5)
  error +1- math::all_equal(y90rot, y90rot3, 0.0001)
  
  math::scalar_let(q, 0,-,y90rot)
  math::slerp(XZ90rot, id, q, 0.5)
  XZ90angle = math::angle(XZ90rot)
  error +1- math::equal_f(XZ90angle, #PI * 0.25)
  
  math::angleAxis(q, 0.1, v010)
  math::slerp(almostid, id, q, 0.5)
  
  math::set_float(q1,  -1,0,0,0)
  math::slerp(q2,  q1, id, 0.5)
  error +1- math::equal_f( Pow(math::dot(id, q2),2), 1, 0.01)
  
  ;slerp spins
  math::set_float(id, 1,0,0,0)
  math::set_float(Y90rot, sqrt2, 0.0, sqrt2, 0.0)
  math::set_float(Y180rot, 0.0, 0.0, 1.0, 0.0)
  
  math::slerp(id2, id, id, 1.0, 1)
  error +1- math::all_equal(id, id2, 0.0001)
  
  math::slerp(id3, id, id, 1.0, 2)
  error +1- math::all_equal(id, id3, 0.0001)
  
  math::slerp(y90rot2, id, y90rot, 1.0,1)
  math::scalar_let(y90rot2, 0,-,y90rot2)
  error +1- math::all_equal(y90rot, y90rot2, 0.0001)
  
  math::slerp(y90rot3, id, y90rot, 8.0 / 9.0, 2)
  error +1- math::all_equal(id, y90rot3, 0.0001)
  
  math::slerp(y90rot4, id, y90rot, 0.2, 1)
  error +1- math::all_equal(y90rot, y90rot4, 0.0001)
  
  math::slerp(ym45rot2, y90rot, id, 0.9, 1)
  math::slerp(ym45rot3, y90rot, id, 0.5)
  math::scalar_let(ym45rot2, 0,-,ym45rot2)
  error +1- math::all_equal(Ym45rot2, ym45rot3, 0.0001)
  
  math::angleAxis(q, #PI*0.5, v001)
  math::set(v,v100)
  math::quat_mul_vec3(u, q, v)
  math::vec3_mul_quat(w, u, q)
  error +1- math::all_equal(v,w,0.1)
  
  ProcedureReturn error
EndProcedure
call(gtc_quaternion)

;- sum  -------------------
output+ "----"+#LF$
output+ "[sum] "+sum+#LF$

CompilerIf #PB_Compiler_Debugger
  Debug output
CompilerElse
  OpenConsole()
  PrintN(output)
  Input()
  CloseConsole()
CompilerEndIf


; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 2
; Folding = x---------
; EnableXP
; EnablePurifier