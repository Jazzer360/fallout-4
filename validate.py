import json
import examine

with open("_data/items.json") as f:
    items = {}
    for item in json.load(f, object_hook=examine.AttrDict):
        items[item.id] = item

def get_by_id(id):
    return items[id]

def listed_as_ingredient(reagent, product):
    for component in product.components:
        if component.id == reagent.id:
            return True
    return False

def listed_as_product(product, reagent):
    for recipe in reagent.used_in:
        if recipe.id == product.id:
            return True
    return False

for item in items.itervalues():
    if 'components' in item:
        for component in item.components:
            if not component.id in items:
                error = "{}\n\tNo item with id: {}"
                print error.format(item.name, component.id)
                continue
            if not 'used_in' in items[component.id]:
                print "warn" + item.name
                continue
            for whereused in items[component.id].used_in:
                if whereused.id == item.id:
                    break
            if not listed_as_product(item, items[component.id]):
                error = "{} does not list {} as a recipe it's part of."
                print error.format(items[component.id].name, item.name)
    if 'used_in' in item:
        for usedin in item.used_in:
            if not usedin.id in items:
                error = "{}\n\tNo item with id: {}"
                print error.format(item.name, usedin.id)
                continue
            if not listed_as_ingredient(item, items[usedin.id]):
                error = "{} does not list {} as a component."
                print error.format(items[usedin.id].name, item.name)
            

