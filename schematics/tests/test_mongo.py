import pytest
from bson.objectid import ObjectId

from schematics.contrib.mongo import ObjectIdType
from schematics.exceptions import ConversionError, ValidationError

FAKE_OID = ObjectId()


def test_to_native():
    oid = ObjectIdType()

    assert oid.to_native(FAKE_OID) == FAKE_OID
    assert oid.to_native(str(FAKE_OID)) == FAKE_OID

    with pytest.raises(ConversionError):
        oid.to_native('foo')


def test_to_primitive():
    oid = ObjectIdType()

    assert oid.to_primitive(FAKE_OID) == str(FAKE_OID)
    assert oid.to_primitive(str(FAKE_OID)) == str(FAKE_OID)


def test_validate_id():
    oid = ObjectIdType()

    assert oid.validate_id(FAKE_OID) is True
    assert oid.validate_id(str(FAKE_OID)) is True

    with pytest.raises(ValidationError):
        oid.validate_id('foo')
