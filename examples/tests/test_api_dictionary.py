import api


def test_dict_init():
    d = api.Dictionary()


def test_dict():
    d = api.Dictionary()
    d["myfloat"] = 10.1
    d["myint"] = 3
    d["hello"] = "world"
    assert d.getentrycount() == 3
    return d.getentrycount()


def test_dict_symbol():
    d = api.Dictionary()
    key, value = "hello", "world"
    d[key] = value
    assert d.getentrycount() == 1
    assert d[key] == value, f"{d[key]} != {value}"


def test_dict_float():
    d = api.Dictionary()
    key, value = "myfloat", 10.1
    d[key] = value
    assert d.getentrycount() == 1
    assert round(d[key], 2) == round(value, 2), f"{d[key]} != {value}"


def test_dict_int():
    d = api.Dictionary()
    key, value = "myint", 3
    d[key] = value
    assert d.getentrycount() == 1
    assert d[key] == value, f"{d[key]} != {value}"


def test_dict_atoms():
    d = api.Dictionary()
    key, value = "mylist", [1, "asym", 12.1]
    d[key] = value
    assert d.getentrycount() == 1
    _value = d[key]
    assert len(_value) == len(value)
    api.post(f"key '{key}' returned {_value}")


def test_dict_bytes():
    d = api.Dictionary()
    key, value = "mybytes", b"some-binary-value-here"
    d[key] = value
    assert d.getentrycount() == 1
    assert d[key] == value, f"{d[key]} != {value}"


def test_dict_update():
    pydict = {"sam": 100, "abc": 121.10, "def": [1, b"pod", "sa", 4.1]}
    d = api.Dictionary()
    for key,value in pydict.items():
        d[key] = value
    return d.getentrycount()





