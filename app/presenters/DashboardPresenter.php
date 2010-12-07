<?php

use Nette\Application\AppForm,
	Nette\Forms\Form;



class DashboardPresenter extends BasePresenter {

	public function renderDefault() {
	  $this->template->numNews = dibi::query('select count(*) from news')->fetchSingle();
	  $this->template->numGB = dibi::query('select count(*) from gb')->fetchSingle();	  
	}
	
	function renderNews() {
	  $this->template->news = dibi::query('select * from news')->fetchAll();
  }
  
  function renderNewsDetail($id) {
    $this->template->item = dibi::query('select * from news where id=%i', $id)->fetch();
  }
  
  function renderGb() {
    $this->template->gb = dibi::query('select * from gb')->fetchAll();
  }
  
  
  function createComponentGuestBookForm() {
    $form = new AppForm;
    $form->addText('from', 'Your name:')->addRule(Form::FILLED, 'Enter your name');
    $form->addText('title', 'Title')->addRule(Form::FILLED, 'Enter title');
    $form->addTextArea('content', 'Your message:');

    $form->addSelect('team', 'Select team', dibi::query('select * from teams')->fetchPairs('id', 'name'))->
            skipFirst("Select team")->addRule(Form::FILLED, 'Select one team');

		$form->addSubmit('save', 'Save')->setAttribute('class', 'default');
		$form->addSubmit('cancel', 'Cancel')->setValidationScope(NULL);
    
    $form->onSubmit[] = callback($this, 'guestBookFormSubmitted');
		$form->addProtection('Please submit this form again (security token has expired).');
    
    return $form;
  }
  
  function guestBookFormSubmitted() {
    $form = $this->getComponent('guestBookForm');
    $values = $form->getValues();
    $values['ip'] = @$_SERVER['REMOTE_ADDR'];
    $values['published'] = date('Y-m-d H:i:s');
    
    dibi::query("insert into gb", $values);
    $this->redirect('gb');
  }


	/********************* views add & edit *********************/



	public function renderAdd()
	{
		$this['albumForm']['save']->caption = 'Add';
	}



	public function renderEdit($id = 0)
	{
		$form = $this['albumForm'];
		if (!$form->isSubmitted()) {
			$album = new Albums;
			$row = $album->find($id)->fetch();
			if (!$row) {
				throw new Nette\Application\BadRequestException('Record not found');
			}
			$form->setDefaults($row);
		}
	}



	/********************* view delete *********************/



	public function renderDelete($id = 0)
	{
		$album = new Albums;
		$this->template->album = $album->find($id)->fetch();
		if (!$this->template->album) {
			throw new Nette\Application\BadRequestException('Record not found');
		}
	}



	/********************* component factories *********************/



	/**
	 * Album edit form component factory.
	 * @return mixed
	 */
	protected function createComponentAlbumForm()
	{
		$form = new AppForm;
		$form->addText('artist', 'Artist:')
			->addRule(Form::FILLED, 'Please enter an artist.');

		$form->addText('title', 'Title:')
			->addRule(Form::FILLED, 'Please enter a title.');

		$form->addSubmit('save', 'Save')->setAttribute('class', 'default');
		$form->addSubmit('cancel', 'Cancel')->setValidationScope(NULL);
		$form->onSubmit[] = callback($this, 'albumFormSubmitted');

		$form->addProtection('Please submit this form again (security token has expired).');
		return $form;
	}



	public function albumFormSubmitted(AppForm $form)
	{
		if ($form['save']->isSubmittedBy()) {
			$id = (int) $this->getParam('id');
			$album = new Albums;
			if ($id > 0) {
				$album->update($id, $form->values);
				$this->flashMessage('The album has been updated.');
			} else {
				$album->insert($form->values);
				$this->flashMessage('The album has been added.');
			}
		}

		$this->redirect('default');
	}



	/**
	 * Album delete form component factory.
	 * @return mixed
	 */
	protected function createComponentDeleteForm()
	{
		$form = new AppForm;
		$form->addSubmit('cancel', 'Cancel');
		$form->addSubmit('delete', 'Delete')->setAttribute('class', 'default');
		$form->onSubmit[] = callback($this, 'deleteFormSubmitted');
		$form->addProtection('Please submit this form again (security token has expired).');
		return $form;
	}



	public function deleteFormSubmitted(AppForm $form)
	{
		if ($form['delete']->isSubmittedBy()) {
			$album = new Albums;
			$album->delete($this->getParam('id'));
			$this->flashMessage('Album has been deleted.');
		}

		$this->redirect('default');
	}

}
