import json
import examine

with open("_data/items.json") as f:
    items = {}
    for item in json.load(f, object_hook=examine.AttrDict):
        items[item.id] = item

def where_used(productid):
    item = items[productid]
    return [i.id for i in item.used_in] if 'used_in' in item else []

def components(productid):
    item = items[productid]
    return [i.id for i in item.components] if 'components' in item else []

missingids, missingcomponents, missingrecipes = [], [], []

for item in items.itervalues():
    for recipeid in where_used(item.id):
        if not recipeid in items:
            errmsg = "No item with id: {}. {} is a component."
            missingids.append(errmsg.format(recipeid, item.name))
            continue
        if not 'effect' in items[recipeid]:
            continue
        if not item.id in components(recipeid):
            errmsg = "{} does not list {} as a component"
            missingcomponents.append(errmsg.format(
                items[recipeid].name, item.name))
    for componentid in components(item.id):
        if not componentid in items:
            errmsg = "No item with id: {}. Used in {}."
            missingids.append(errmsg.format(componentid, item.name))
            continue
        if not 'effect' in items[componentid]:
            continue
        if not item.id in where_used(componentid):
            errmsg = "{} does not show {} as a recipe it's used in."
            missingrecipes.append(errmsg.format(
                items[componentid].name, item.name))

print '\n'.join(missingids)
print '\n'.join(missingcomponents)
print '\n'.join(missingrecipes)