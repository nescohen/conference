package com.prodyna.pac.conference.entity;

import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;
import org.springframework.hateoas.core.Relation;

@NodeEntity
public class Room {

    @Id
    @GeneratedValue
    public Long _id;

    @Relationship(type="IN_LOCATION")
    public Location location;

}