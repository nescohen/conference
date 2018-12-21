load csv with headers from "file:/import/person.csv" as line fieldterminator ','
	merge (p:Person {id:line.id})
		set p.name = line.name;

load csv with headers from "file:/import/location.csv" as line fieldterminator ','
	merge (l:Location {id:line.id})
		set l.name = line.name;

load csv with headers from "file:/import/room.csv" as line fieldterminator ','
	merge (r:Room {id:line.id})
		set r.name = line.name,
		r.location = line.location;

load csv with headers from "file:/import/slot.csv" as line fieldterminator ','
	merge (s:Slot {id:line.id})
		set s.event = line.event,
 		s.room = line.room,
                s.datetime = line.datetime;

load csv with headers from "file:/import/event.csv" as line fieldterminator ','
	merge (e:Event {id:line.id})
		set e.location = line.location,
                e.name = line.name,
 		e.startDate = line.startDate,
                e.endDate = line.endDate;

load csv with headers from "file:/import/talk.csv" as line fieldterminator ','
	merge (t:Talk {id:line.id})
		set t.persons = split(line.persons,";"),
		t.slots = split(line.slots,";"),
		t.title = line.title,
		t.language = line.language,
		t.topics = split(line.topics,';');

load csv with headers from "file:/import/language.csv" as line
	merge (l:Language {id:line.id})
		set l.name = line.name;

load csv with headers from "file:/import/topic.csv" as line fieldterminator ','
	merge (to:Topic {id:line.id})
		set to.name = line.name,
		to.parents = split(line.parents,";");

match (r:Room),(l:Location) where r.location = l.id
	merge (r)-[:IN_LOCATION]->(l);

match (e:Event),(l:Location) where e.location = l.id 
	merge (e)-[:IN_LOCATION]->(l);

match (s:Slot),(e:Event)--(l:Location)--(r:Room) where s.event = e.id and s.room = r.id
	merge (s)-[:ON_EVENT]->(e)
	merge (s)-[:IN_ROOM]->(r);

match (t:Talk),(s:Slot) where s.id in t.slots
	merge (t)-[:IN_SLOT]->(s);

match (t:Talk),(p:Person) where p.id in t.persons
	merge (t)-[:BY_PERSON]->(p);

match (t:Talk),(l:Language) where t.language = l.id
	merge (t)-[:IN_LANGUAGE]->(l);

match (c:Topic)-[r]->(p:Topic) delete r;
match (c:Topic) match (p:Topic) where p.id in c.parents
	merge (c)-[:PART_OF]->(p);

match (t:Talk) match (to:Topic) where to.id in t.topics
	merge (t)-[:IS_ABOUT]->(to);

match (t:Talk) remove t.topics,t.persons,t.slots,t.language;
match (to:Topic) remove to.parents;
match (r:Room) remove r.location;
match (s:Slot) remove s.room, s.event;
match (e:Event) remove e.location;

