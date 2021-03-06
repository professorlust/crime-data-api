import pytest
from crime_data.common.base import ExplorerOffenseMapping
from crime_data.common.cdemodels import OffenseOffenderCountView


class TestOffenseOffenderCountView:
    """Test the OffenseOffenderCountView"""

    def test_count_for_a_state(self, app):
        v = OffenseOffenderCountView('race_code', year=2014, state_id=44, offense_name='Impersonation', as_json=False)
        results = v.query({}).fetchall()
        expected = {
            'U': 1
        }
        assert len(results) == 10 # all the race code options
        for row in results:
            assert 'count' in row
            if row['count']:
                assert row['count'] == expected[row['race_code']]

    @pytest.mark.parametrize('year', [2014, None])
    @pytest.mark.parametrize('state_id', [41, None])
    @pytest.mark.parametrize('offense_name', ['Shoplifting', None])
    @pytest.mark.parametrize('variable', OffenseOffenderCountView.VARIABLES)
    def test_endpoint(self, app, year, state_id, offense_name, variable):
        v = OffenseOffenderCountView(variable, year=year, state_id=state_id, offense_name=offense_name, as_json=False)
        results = v.query({}).fetchall()
        assert len(results) > 0

        seen_values = set()
        for row in results:
            assert 'count' in row
            row_key = (row.year, row[variable], )
            assert row_key not in seen_values
            seen_values.add(row_key)

    @pytest.mark.parametrize('explorer_offense', ExplorerOffenseMapping.NIBRS_OFFENSE_MAPPING.keys())
    @pytest.mark.parametrize('variable', OffenseOffenderCountView.VARIABLES)
    def test_endpoint_for_explorer_offense(self, app, explorer_offense, variable):
        v = OffenseOffenderCountView(variable, year=1992, state_id=2, explorer_offense=explorer_offense, as_json=False)
        results = v.query({}).fetchall()
        if len(results) > 0:
            # seen_values = set()
            # for row in results:
            #     row_key = (row.year, row.offense_name, row[variable], )
            #     assert row_key not in seen_values
            #     seen_values.add(row_key)
            for row in results:
                assert 'count' in row

    def test_explorer_offense_does_aggregation(self, app):
        v = OffenseOffenderCountView('sex_code', year=2014, state_id=26, explorer_offense='larceny', as_json=False)
        results = v.query({}).fetchall()
        expected = [
            ('2014', 'larceny', 'F', 1),
            ('2014', 'larceny', 'M', 2)]
        #assert len(results) == len(expected)
        # for row, expect in zip(results, expected):
        #     assert row == expect
        for row in results:
            assert 'count' in row
