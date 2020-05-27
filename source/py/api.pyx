"""

(1) If the .pxd file is the same name as the pyx file:
        cython implicitly includes all names into the pyx file from the pxd

    This means you cannot redefine the c-names

(2) If the pxd is not named as the pyx file:
        all references the c-name have to be qualified but then
        it is possible to redefine the c-name in python 'def'


Note: with (2), you have to close Max to reload c api otherwise
      it will read as None. 

      (1) needs to be tested for the sam behaviour

"""

cimport api_max as mx # api is a cython keyword!


cdef extern from "py.h":
    cdef int PY_MAX_ATOMS
    # cdef char *PY_NAME
    cdef char *PY_NAMESPACE

    ctypedef struct t_py

    cdef void py_bang(t_py *x)
    cdef void py_import(t_py *x, mx.t_symbol *s)
    cdef void py_eval(t_py *x, mx.t_symbol *s, long argc, mx.t_atom *argv)
    cdef void py_exec(t_py *x, mx.t_symbol *s, long argc, mx.t_atom *argv)
    cdef void py_execfile(t_py *x, mx.t_symbol *s, long argc, mx.t_atom *argv)
    cdef void py_run(t_py *x, mx.t_symbol *s, long argc, mx.t_atom *argv)
    cdef void py_dblclick(t_py *x)
    cdef void *py_new(mx.t_symbol *s, long argc, mx.t_atom *argv)
    cdef void py_free(t_py *x)
    cdef void py_init(t_py *x)


txt = "Hey MAX!"

greeting = 'Hello World'

# name = lambda: getattr(globals(), 'PY_NAME')


cpdef public str hello():
    return greeting

def post(str s):
     mx.post(s.encode('utf-8'))

def error(str s):
     mx.error(s.encode('utf-8'))

# cpdef public void py_post(str s):
#     mx.error(s.encode('utf-8'))

# cpdef public void py_error(str s):
#     mx.error(s.encode('utf-8'))


cdef class PyExternal:
    cdef t_py *obj

    def __cinit__(self, bytes name):
        self.obj = <t_py *>mx.object_findregistered(mx.CLASS_BOX, mx.gensym(name))

    cpdef bang(self):
        py_bang(self.obj)


def test(key='PY_NAME'):
    if key in globals():
        s = globals()[key]
        ext = PyExternal(bytes(s))
        ext.bang()
    else:
        return 'nope'




