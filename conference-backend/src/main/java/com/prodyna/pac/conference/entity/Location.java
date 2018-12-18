package com.prodyna.pac.conference.entity;

import lombok.*;
import org.neo4j.ogm.annotation.*;
import org.springframework.hateoas.core.Relation;

import java.util.Set;

@NodeEntity
@Data
public class Location {

    @Id
    @GeneratedValue
    private Long _id;

    @Index(unique = true)
    private String name;

    @Relationship(type="IN_LOCATION", direction=Relationship.INCOMING)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Set<Room> rooms;

    @Relationship(type="IN_LOCATION", direction = Relationship.INCOMING)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Set<Event> events;

}
