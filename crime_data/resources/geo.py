from flask import jsonify
import flask_apispec as swagger
from webargs.flaskparser import use_args
from crime_data.extensions import DEFAULT_MAX_AGE
from flask.ext.cachecontrol import cache
from marshmallow import fields
from crime_data.common import cdemodels, marshmallow_schemas, models
from crime_data.common.base import CdeResource, tuning_page


class StateDetail(CdeResource):
    schema = marshmallow_schemas.StateDetailResponseSchema()

    @use_args(marshmallow_schemas.ArgumentsSchema)
    @swagger.use_kwargs(marshmallow_schemas.ApiKeySchema, apply=False, locations=['query'])
    @swagger.marshal_with(marshmallow_schemas.StateDetailResponseSchema, apply=False)
    @swagger.doc(tags=['geo'],
                 params={'state_id': {'description': 'A state postal abbreviation'}},
                 description=['Returns basic information about a state and lists counties in the state'])
    @cache(max_age=DEFAULT_MAX_AGE, public=True)
    @tuning_page
    def get(self, args, id):
        self.verify_api_key(args)
        state = cdemodels.CdeRefState.get(abbr=id).one()
        return jsonify(self.schema.dump(state).data)


class CountyDetail(CdeResource):
    schema = marshmallow_schemas.CountyDetailResponseSchema()

    @use_args(marshmallow_schemas.ArgumentsSchema)
    @swagger.use_kwargs(marshmallow_schemas.ApiKeySchema, apply=False, locations=['query'])
    @swagger.marshal_with(marshmallow_schemas.CountyDetailResponseSchema, apply=False)
    @swagger.doc(tags=['geo'], description='Demographic details for a county')
    @cache(max_age=DEFAULT_MAX_AGE, public=True)
    @tuning_page
    def get(self, args, fips):
        self.verify_api_key(args)
        county = cdemodels.CdeRefCounty.get(fips=fips).one()
        return jsonify(self.schema.dump(county).data)


class StateParticipation(CdeResource):
    schema = marshmallow_schemas.ParticipationRateSchema(many=True)

    @use_args(marshmallow_schemas.ArgumentsSchema)
    @swagger.use_kwargs(marshmallow_schemas.ApiKeySchema, apply=False, locations=['query'])
    @swagger.marshal_with(marshmallow_schemas.ParticipationRateSchema, apply=False)
    @swagger.doc(tags=['geo'], description='Participation data for a state')
    @cache(max_age=DEFAULT_MAX_AGE, public=True)
    @tuning_page
    def get(self, args, state_id=None, state_abbr=None):
        self.verify_api_key(args)

        if state_abbr:
            state_id = cdemodels.CdeRefState.get(abbr=state_abbr).one().state_id

        rates = cdemodels.CdeParticipationRate(state_id=state_id).query.order_by('data_year DESC').all()
        return jsonify(self.schema.dump(rates).data)
