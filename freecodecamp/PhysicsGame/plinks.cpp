#include "plinks.h"

using namespace BakariPhysicsPlus;

real ParticleLink::currentLength() const
{
    Vector3 relativePos = particle[0]->getPosition() -
                          particle[1]->getPosition();
    return relativePos.magnitude();
}

unsigned ParticleCable::addContact(ParticleContact *contact,
                                    unsigned limit) const
{
    // Find the length of the cable
    real length = currentLength();

    // Check if we're over-extended
    if (length < maxLength)
    {
        return 0;
    }

    // Otherwise return the contact
    contact->particle[0] = particle[0];
    contact->particle[1] = particle[1];

    // Calculate the normal
    Vector3 normal = particle[1]->getPosition() - particle[0]->getPosition();
    normal.normalize();
    contact->contactNormal = normal;

    contact->penetration = length-maxLength;
    contact->restitution = restitution;

    return 1;
}

unsigned ParticleRod::addContact(ParticleContact *contact,
                                  unsigned limit) const
{
    // Find the length of the rod
    real currentLen = currentLength();

    // Check if we're over-extended
    if (currentLen == length)
    {
        return 0;
    }

    // Otherwise return the contact
    contact->particle[0] = particle[0];
    contact->particle[1] = particle[1];

    // Calculate the normal
    Vector3 normal = particle[1]->getPosition() - particle[0]->getPosition();
    normal.normalize();

    // The contact normal depends on whether we're extending or compressing
    if (currentLen > length) {
        contact->contactNormal = normal;
        contact->penetration = currentLen - length;
    } else {
        contact->contactNormal = normal * -1;
        contact->penetration = length - currentLen;
    }

    // Always use zero restitution (no bounciness)
    contact->restitution = 0;

    return 1;
}

real ParticleConstraint::currentLength() const
{
    Vector3 relativePos = particle->getPosition() - anchor;
    return relativePos.magnitude();
}

unsigned ParticleCableConstraint::addContact(ParticleContact *contact,
                                   unsigned limit) const
{
    // Find the length of the cable
    real length = currentLength();

    // Check if we're over-extended
    if (length < maxLength)
    {
        return 0;
    }

    // Otherwise return the contact
    contact->particle[0] = particle;
    contact->particle[1] = 0;

    // Calculate the normal
    Vector3 normal = anchor - particle->getPosition();
    normal.normalize();
    contact->contactNormal = normal;

    contact->penetration = length-maxLength;
    contact->restitution = restitution;

    return 1;
}

unsigned ParticleRodConstraint::addContact(ParticleContact *contact,
                                 unsigned limit) const
{
    // Find the length of the rod
    real currentLen = currentLength();

    // Check if we're over-extended
    if (currentLen == length)
    {
        return 0;
    }

    // Otherwise return the contact
    contact->particle[0] = particle;
    contact->particle[1] = 0;

    // Calculate the normal
    Vector3 normal = anchor - particle->getPosition();
    normal.normalize();

    // The contact normal depends on whether we're extending or compressing
    if (currentLen > length) {
        contact->contactNormal = normal;
        contact->penetration = currentLen - length;
    } else {
        contact->contactNormal = normal * -1;
        contact->penetration = length - currentLen;
    }

    // Always use zero restitution (no bounciness)
    contact->restitution = 0;

    return 1;
}