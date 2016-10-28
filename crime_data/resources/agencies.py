import re

from flask_restful import fields, marshal_with, reqparse
from webargs.flaskparser import use_args

from crime_data.common import cdemodels as models
from crime_data.common import marshmallow_schemas
from crime_data.common.base import CdeResource

from crime_data.common.marshmallow_schemas import (
    ArgumentsSchema, IncidentArgsSchema, IncidentCountArgsSchema, AgenciesRetaArgsSchema)

class AgenciesResource(CdeResource):

    schema = marshmallow_schemas.RefAgencySchema(many=True)


class AgenciesList(AgenciesResource):
    @use_args(marshmallow_schemas.ArgumentsSchema)
    def get(self, args):
        self.verify_api_key(args)
        result = models.CdeRefAgency.query
        return self.with_metadata(result, args)


class AgenciesDetail(AgenciesResource):
    @use_args(marshmallow_schemas.ArgumentsSchema)
    def get(self, args, nbr):
        self.verify_api_key(args)
        agency = models.CdeRefAgency.query.filter_by(ori=nbr)
        return self.with_metadata(agency, args)


class AgenciesNibrsCount(CdeResource):

    SPLITTER = re.compile(r"\s*,\s*")

    @use_args(AgenciesRetaArgsSchema)
    def get(self, args, ori=None):
        '''''
        Get Incident Count by Agency ID/ORI.
        ''' ''
        self.verify_api_key(args)
        by = []

        by = self.SPLITTER.split(
            args['by'].lower())  # TODO: can post-process in schema?

        query = models.CdeNibrsIncident.get_nibrs_incident_by_ori(ori, args, by)
        return self.with_metadata(query, args)

class AgenciesRetaCount(CdeResource):

    SPLITTER = re.compile(r"\s*,\s*")

    @use_args(AgenciesRetaArgsSchema)
    def get(self, args, ori=None):
        '''''
        Get Incident Count by Agency ID/ORI.
        '''''
        self.verify_api_key(args)
        by = []

        by = self.SPLITTER.split(
            args['by'].lower())  # TODO: can post-process in schema?

        query = models.CdeRetaMonth.get_reta_by_ori(ori, args, by)
        result = self.with_metadata(query, args)

        return result
