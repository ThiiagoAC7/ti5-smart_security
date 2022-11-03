"""empty message

Revision ID: 64e6746a45d3
Revises: 
Create Date: 2022-11-02 21:11:22.623594

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '64e6746a45d3'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('users',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('user_name', sa.String(), nullable=False),
    sa.Column('password', sa.String(), nullable=False),
    sa.Column('api_key', sa.String(), nullable=False),
    sa.Column('creation_date', sa.TIMESTAMP(), server_default=sa.text('CURRENT_TIMESTAMP'), nullable=False),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('rfid',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('rfid', sa.String(), nullable=False),
    sa.Column('object', sa.String(), nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('activity_log',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('rfid_id', sa.Integer(), nullable=False),
    sa.Column('type', sa.String(), nullable=False),
    sa.Column('log', sa.String(), nullable=False),
    sa.ForeignKeyConstraint(['rfid_id'], ['rfid.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('activity_log')
    op.drop_table('rfid')
    op.drop_table('users')
    # ### end Alembic commands ###